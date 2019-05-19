# Django Contribution チュートリアル開発環境

[Django への初めてのパッチを書く](https://docs.djangoproject.com/ja/2.2/intro/contributing/#id12)に掲載されている環境構築を自動化したものです。

MacやWindowsで環境作るのが辛かったり環境を汚したくない場合とかに使ってください。

## 起動

あらかかじめチュートリアルページで自身のアカウントにdjangoのリポジトリをフォークしておいてください。

```bash
git clone https://github.com/Sakaki/django_dev_tutorial.git
cd django_dev_tutorial
docker build -t "django-dev" --build-arg github_account=[GitHubのアカウント名] .
docker run -it --rm django-dev
```

## テスト

```bash
pip install -r /django/tests/requirements/py3.txt
su - test
/django/tests/runtests.py
```

## TODO

* testユーザーだと `pip install` がこける問題
* データの永続化
