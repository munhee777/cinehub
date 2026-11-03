# CINEHUB

영화 탐색, AI 기반 추천, 영화 커뮤니티를 하나로 연결한 팀 프로젝트입니다. 제목 검색에 더해 “우주를 떠도는 과학자”, “비 오는 날 혼자 보기 좋은 영화”처럼 자연어로 영화를 찾을 수 있습니다.

> 팀 프로젝트 결과물입니다. 이 저장소의 공개와 재사용 권한은 조직 및 기여자 확인이 끝난 뒤 결정해야 합니다. 원본 프로젝트에는 라이선스 파일이 없으며, 포함된 이미지·폰트·오픈소스 자산의 배포 조건도 확인이 필요합니다.

## 프로젝트 개요

- Java JDK `HttpServer`와 JDBC로 구현한 웹 애플리케이션
- Oracle XE의 키워드 검색과 Qdrant의 의미 검색을 결합한 영화 추천
- OpenAI API를 이용한 추천 후보 선택과 설명 생성
- TMDB API를 통한 영화 정보와 유사 영화 조회

## 주요 기능

- 회원가입, 로그인, 세션 기반 인증 및 CSRF 검증
- 영화 제목·줄거리 검색, 자연어 의미 검색, 랜덤 추천
- 장르 취향 설문과 32강 영화 선택 게임
- 게시글, 댓글, 좋아요, 신고 및 관리자 기능
- 관리자 감사 로그와 계정 상태 관리

## 담당 역할

제가 맡은 Backend/API 작업입니다.

- Java 세션·CSRF 기반 회원 인증 및 인가
- 게시글·댓글·좋아요와 영화 추천 API
- 회원 관리, 신고 처리, 감사 로그를 포함한 관리자 API

## 기술 스택

| 영역 | 기술 |
|---|---|
| Backend | Java 17+, JDK `HttpServer`, JDBC |
| Frontend | HTML, CSS, Vanilla JavaScript |
| Database | Oracle XE |
| Vector search | Qdrant |
| AI | OpenAI API |
| Movie data | TMDB API |

## 실행 준비

- JDK 17 이상
- Oracle XE와 프로젝트 스키마
- 로컬에서 실행 중인 Qdrant (`127.0.0.1:6333`)
- `lib/`에 Oracle JDBC 및 SLF4J 라이브러리
- `DB_URL`, `DB_USER`, `DB_PASSWORD` 환경 변수
- AI 및 TMDB 기능을 사용할 경우 `OPENAI_API_KEY`, `TMDB_READ_TOKEN` 또는 `TMDB_API_KEY` 환경 변수

Windows PowerShell에서 `run.ps1`을 실행하면 Oracle 비밀번호를 입력받아 서버를 시작합니다. Qdrant는 별도로 실행해야 합니다. 키와 비밀번호를 코드나 저장소에 적지 마세요.

## 팀 크레딧

| 기여자 | 담당 |
|---|---|
| [노건우 (@asdg441)](https://github.com/asdg441) | 프로젝트 리드, AI 추천 및 영화 데이터 |
| [이연화 (@dusghk0802)](https://github.com/dusghk0802) | 화면 설계·구현, 데이터베이스 설계 |
| [조문희 (@munhee777)](https://github.com/munhee777) | Backend/API, 인증·인가, 커뮤니티 및 관리자 기능 |

## 구조

```text
src/project/          Java HTTP API, DAO, 인증, 추천 서비스
webapp/               HTML, CSS, JavaScript 및 DB 스키마
webapp/db/             Oracle 스키마와 데이터베이스 명세서
docs/                  ERD와 서비스 구조 문서
run.ps1                Windows 개발 실행 스크립트
```

## 보안 및 라이선스

`.env`, API 키, 데이터베이스 비밀번호, 로그, 데이터베이스 파일과 컴파일 산출물은 저장소에 추가하지 않습니다. 외부 배포 시 Oracle과 Qdrant를 인터넷에 직접 노출하지 마세요.

원본 팀 저장소에 라이선스가 없으므로, 공개 전에 조직의 배포 허가와 기여자 권한을 확인하고 제3자 라이브러리·이미지·폰트의 라이선스 및 고지 사항을 정리해야 합니다.
