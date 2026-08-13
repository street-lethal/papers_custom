if [ ! -e .env ]; then
  echo -e "USER_ID=$UID\nGROUP_ID=$UID" > .env
  sed -n '1,2!p' .env.sample >> .env
fi
docker-compose build
