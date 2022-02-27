# 개발 history

EC2에 Amazon Linux 2를 올리고 django 설치 후 runserver 하면 sqlite 버전 이슈로 중단됨.

sqllite 새로 받아서 make하는데 안됨
gcc 없어서
al2에 gcc 설치는 아래링크
https://docs.aws.amazon.com/ko_kr/AWSEC2/latest/UserGuide/compile-software.html

그다음 yum install -y gcc

그리고 sudo ./configure

https://ossian.tistory.com/109


서버 실행하고 외부접근 안될거임. localhost만 리턴됨.
django의 ALLOW_HOSTS 설정 때문임
settings.py에서 어떤 호스트도메인에 대해서 열어줄건지 세팅해야됨.
도메인 따로 안했으므로 publicip로 접근할거고, 이게 hostheader에 들어갈거니까
ALLOWED_HOSTS = ["3.37.66.238"]가 되어야 함.
python manage.py runserver 8080 로컬에만 열림
python manage.py runserver 0:8000 외부접근 가능


runserver.py 좋은게 설정이든 코드든 수정되는거 바로바로 반영됨. 굿.

mysite라는 프로젝트를 생성한거고
polls라는 앱을 생성한거임
프로젝트와 앱의 tree구조는 다름

 