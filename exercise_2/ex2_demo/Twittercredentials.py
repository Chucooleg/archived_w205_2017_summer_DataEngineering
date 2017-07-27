import tweepy

consumer_key = "M79sNC9weCSs4NntRztWh8PIf";

consumer_secret = "PgygBDxuMbgLPZj3q8PwNBRysrA17kDFXi5N9BPkNTriX2L8MI";

access_token = "825099890824876032-KEWeyKnV380CizbgRt6DVsebWLwvMr1";

access_token_secret = "4vYOwvoNoiDoeSecZdOLOck7CJwNHOsJ5zmVULWXptCMp";


auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)

api = tweepy.API(auth)
