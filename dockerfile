# 베이스 이미지로 Tomcat 9와 JDK 17을 사용합니다.
FROM tomcat:9-jdk17-openjdk-slim

# 작업 디렉토리를 Tomcat의 웹 애플리케이션 디렉토리로 설정합니다.
WORKDIR /usr/local/tomcat/webapps

# Maven 빌드로 생성된 WAR 파일을 컨테이너의 webapps 디렉토리로 복사합니다.
# ROOT.war로 이름을 변경하여 컨텍스트 루트에서 애플리케이션이 실행되도록 합니다.
COPY target/*.war ROOT.war

# 컨테이너가 리스닝할 포트를 지정합니다. (Tomcat의 기본 포트)
EXPOSE 8080

# 컨테이너가 시작될 때 Tomcat을 실행합니다.
CMD ["catalina.sh", "run"]