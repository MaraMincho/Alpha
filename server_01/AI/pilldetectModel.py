import os
import warnings
warnings.filterwarnings(action='ignore')

import io
import cv2
import keras
import pickle
import logging
import imutils
import pandas
import argparse
import numpy as np
import pandas as pd
import tensorflow as tf

from PIL import Image
from google.cloud import vision
from keras.models import load_model
from google.cloud.vision_v1 import types
from keras.utils.image_utils import img_to_array 

os.environ['TF_XLA_FLAGS'] = '--tf_xla_enable_xla_devices'
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "AI/seraphic-rarity-373904-e25d9c3b1870.json"

tf.autograph.set_verbosity(3)
tf.get_logger().setLevel(logging.ERROR)

# Google Vision API를 통한 글자 인식
def txtdetect(img_dir):
    client = vision.ImageAnnotatorClient()

    file_name = os.path.join(os.path.abspath("__file__"), img_dir)

    file_name = img_dir

    with io.open(file_name, 'rb') as image_file:
        content = image_file.read()

    image = types.Image(content=content)

    respose = client.text_detection(image=image)
    labels = respose.text_annotations

    # 인식된 글자를 리스트에 추가
    for label in labels:
        findtxt.append(label.description)

    return findtxt


def test(img_dir):
    image = cv2.imread(img_dir)
    output = imutils.resize(image, width=400)

    # 이미지 전처리 수행
    image = cv2.resize(image, (96, 96))
    image = image.astype("float") / 255.0
    image = img_to_array(image)
    image = np.expand_dims(image, axis=0)

    # 모델과 MLB 로드
    model = load_model('./pill_model.h5')
    mlb = pickle.loads(open('./mlb.txt', "rb").read())

    # 상위 4개의 확률을 가진 라벨 출력
    proba = model.predict(image)[0]
    idxs = np.argsort(proba)[::-1][:4]
    for (i, j) in enumerate(idxs):
        colnshape.append(mlb.classes_[j])
       
    cv2.waitKey(0)

    # colnshape로 라벨 반환
    return colnshape

# 이미지 이름 변경
def rename():
    
    parser = argparse.ArgumentParser()
    parser.add_argument('img_dir', type=str, help="input_img")

    args = parser.parse_args()

    img_dir = args.img_dir
    image = Image.open(img_dir)
    image_size = image.size

    new_image = Image.new('RGB', (1 * image_size), (250, 250, 250))
    new_image.paste(image, (0, 0))
    new_image.save("input.jpeg", "JPEG")


def get_jaccard_sim(str1, str2):
    # 음각 유사도 jaccard 유사도 진행
    a = set(str1)
    b = set(str2)
    c = a.intersection(b)
    return float(len(c)) / (len(a) + len(b) - len(c))

# 메인 함수 시작
if __name__ == "__main__":
    # 이미지 크기 가공
    rename()
    img = Image.open('input.jpeg')
    img_resize = img.resize((int(img.width / 2), int(img.height / 2)))
    img_resize.save('input.jpeg')
    findtxt = []

    # input 이미지에서 추출된 글자 저장
    findtxt = txtdetect('input.jpeg')
   
    # 낱알식별정보 파일 불러오기
    xlsx = pd.read_excel('OpenData_PotOpenTabletIdntfc20230116.xlsx', usecols='A,I,J,G,H', engine='openpyxl')
    finalpilllist = []
    pilllist = []
    indexlist = []

    # 글자를 읽지 못했으면
    if not findtxt:
        # 빈 리스트 리턴
        pilllist = []

    else:
        # 글자를 읽었으면
        check = 0
        for a in range(len(findtxt)):
            # 추출된 글자 정제
            findtxt[a] = findtxt[a].rstrip('\n')
            findtxt[a] = findtxt[a].replace('\n', ' ')
            findtxt[a] = findtxt[a].replace('\'', '')
            findtxt[a] = findtxt[a].replace('.', '')

        # 글자에 공백이 있는 경우
        if ' ' in findtxt[0]:
            findtxt.append(findtxt[0].replace(' ', ''))
            check = 1

        for index in range(24800):
            # 추출된 글자를 모두 포함하고 있는 위치 인덱스와 일치하는 알약 pilllist 에 append
            if check == 0:
                if (findtxt[0] == str(xlsx['표시앞'][index])) or (findtxt[0] == str(xlsx['표시뒤'][index])):
                    # 오류가 있는 항목 예외처리
                    if xlsx['품목일련번호'][index] != 200806190 and xlsx['품목일련번호'][index] != 200806191 and \
                            xlsx['품목일련번호'][index] != 200806192:
                        if xlsx['품목일련번호'][index] not in pilllist:
                            pilllist.append(xlsx['품목일련번호'][index])
                            indexlist.append(index)
                    else:
                        pilllist.append(xlsx['품목일련번호'][index])
                        indexlist.append(index)
            else:
                if (findtxt[0] == str(xlsx['표시앞'][index])) or (findtxt[0] == str(xlsx['표시뒤'][index])) or (
                        findtxt[-1] == str(xlsx['표시앞'][index])) or (findtxt[-1] == str(xlsx['표시뒤'][index])):
                    if xlsx['품목일련번호'][index] != 200806190 and xlsx['품목일련번호'][index] != 200806191 and \
                            xlsx['품목일련번호'][index] != 200806192:
                        if xlsx['품목일련번호'][index] not in pilllist:
                            pilllist.append(xlsx['품목일련번호'][index])
                            indexlist.append(index)
                    else:
                        pilllist.append(xlsx['품목일련번호'][index])
                        indexlist.append(index)

        # 글자가 100% 일치하지 않으면 추출된 모든 글자를 비교(글자 일치율이 높은 알약에 대해 우선적으로 append )
        if not pilllist:
            for index in range(24800):
                for c in range(len(findtxt)):
                    if (findtxt[c] == str(xlsx['표시앞'][index])):
                        for d in range(len(findtxt)):
                            if (findtxt[d] == str(xlsx['표시뒤'][index])):
                                if xlsx['품목일련번호'][index] != 200806190 and xlsx['품목일련번호'][
                                    index] != 200806191 and xlsx['품목일련번호'][index] != 200806192:
                                    if xlsx['품목일련번호'][index] not in pilllist:
                                        pilllist.append(xlsx['품목일련번호'][index])
                                        indexlist.append(index)
                                else:
                                    pilllist.append(xlsx['품목일련번호'][index])
                                    indexlist.append(index)

            for index in range(24800):
                for c in range(len(findtxt)):
                    if (findtxt[c] == str(xlsx['표시뒤'][index])):
                        for d in range(len(findtxt)):
                            if (findtxt[d] == str(xlsx['표시앞'][index])):
                                if xlsx['품목일련번호'][index] != 200806190 and xlsx['품목일련번호'][
                                    index] != 200806191 and xlsx['품목일련번호'][index] != 200806192:
                                    if xlsx['품목일련번호'][index] not in pilllist:
                                        pilllist.append(xlsx['품목일련번호'][index])
                                        indexlist.append(index)
                                else:
                                    pilllist.append(xlsx['품목일련번호'][index])
                                    indexlist.append(index)

            for index in range(24800):
                for c in range(len(findtxt)):
                    if (findtxt[c] == str(xlsx['표시앞'][index])) or (findtxt[c] == str(xlsx['표시뒤'][index])):
                        if xlsx['품목일련번호'][index] != 200806190 and xlsx['품목일련번호'][index] != 200806191 and \
                                xlsx['품목일련번호'][index] != 200806192:
                            if xlsx['품목일련번호'][index] not in pilllist:
                                pilllist.append(xlsx['품목일련번호'][index])
                                indexlist.append(index)
                        else:
                            pilllist.append(xlsx['품목일련번호'][index])
                            indexlist.append(index)


        '''''''''''''''''''''''''''''
        '파악된 정보에 따른 결과 반환'
        '''''''''''''''''''''''''''''

        # 추출된 글자와 일치하는 알약이 1개일 경우
        if len(pilllist) == 1:
            # 해당하는 알약 정보 반환
            finalpilllist = pilllist

            # 추출된 글자와 일치하는 알약이 1개보다 많은 경우
        elif len(pilllist) > 1:

            # 오픈소스를 활용하여 배경 제거 후 모양과 색깔 식별 진행  
            os.system("python3 AI/removebg.py -i input.jpeg -o output.png -m u2net -prep None -postp No")

            colnshape = []
            colnshape = test('output.png')

            shape = []
            color = []

            # 예측값에 대해서 색깔과 제형으로 분리
            for a in range(len(colnshape)):
                # 이름에 '형'이 들어가면
                if colnshape[a][-1] == chr(54805): 
                    # 제형
                    shape.append(colnshape[a])  
                # 이름에 '형'이 들어가지 않으면
                else:             
                    # 색깔              
                    color.append(colnshape[a])  

            for c in range(len(color)):
                for s in range(len(shape)):
                    for index in range(len(indexlist)):
                        if (xlsx['의약품제형'][indexlist[index]] == shape[s] and xlsx['색상앞'][indexlist[index]] == color[c]):
                            if xlsx['품목일련번호'][indexlist[index]] not in finalpilllist:
                                finalpilllist.append(xlsx['품목일련번호'][indexlist[index]])

    # 최종적으로 예측된 pilllist가 없을 때
    if not finalpilllist:
        
        # 글자만 일치했던 pilllist 에서 상위 5개 출력
        if len(pilllist) > 5:
            temp = ''
            for i in pilllist[:5]:
                temp = temp + str(i) + ','
            print(temp)
        else:
            temp = ''
            for i in pilllist:
                temp = temp + str(i) + ','
            print(temp)
    else:
        # 최종적으로 예측된 pilllist 가 있을 때
        temp = ''
        for i in finalpilllist[:5]:
            temp = temp + str(i) + ','
        print(temp)



