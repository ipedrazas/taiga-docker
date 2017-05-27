@ECHO OFF

set api_name=%API_NAME%

IF "%api_name%" == "" (
    set API_NAME="localhost"
)

set postgres_data=%POSTGRES_DATA%

IF "%postgres_data%" == "" (
	set POSTGRES_DATA=".\data"
)

echo API_NAME: %API_NAME%
echo POSTGRES_DATA: %POSTGRES_DATA%

:: letting the script create the folder will result in ownership conflict with docker
::IF NOT EXIST %POSTGRES_DATA% (
::	mkdir %POSTGRES_DATA%
::)

docker run -d --name postgres  -v %POSTGRES_DATA%:/var/lib/postgresql/data postgres
:: postgres needs some time to startup
sleep 5
docker run -d --name taiga-back  -p 8000:8000 -e API_NAME=%API_NAME%  --link postgres:postgres ipedrazas/taiga-back
docker run -d --name taiga-front -p 80:80 -e API_NAME=%API_NAME% --link taiga-back:taiga-back --volumes-from taiga-back ipedrazas/taiga-front

docker run -it --link postgres:postgres --rm postgres sh -c "su postgres --command 'createuser -h "'$POSTGRES_PORT_5432_TCP_ADDR'" -p "'$POSTGRES_PORT_5432_TCP_PORT'" -d -r -s taiga'"
docker run -it --link postgres:postgres --rm postgres sh -c "su postgres --command 'createdb -h "'$POSTGRES_PORT_5432_TCP_ADDR'" -p "'$POSTGRES_PORT_5432_TCP_PORT'" -O taiga taiga'";
docker run -it --rm --link postgres:postgres ipedrazas/taiga-back bash regenerate.sh







