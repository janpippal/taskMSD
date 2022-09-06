# taskMSD
## API
### For API task I took Postman and did a longer scenario with Trello
1. create a board (C)
2. receive the board that was created (R)
3. update board by adding description (U)
4. get lists for the board
5. use To Do list to create a card
6. Move card to Doing list and verify
7. Move card to Done list and verify
8. Delete the board (D)

To run either open in postman or run in newman (dont forget to setup your account key and token --security)

```newman run Trello_Jan_Pippal.postman_collection.json --env-var "key=YOUR_KEY" --env-var "token=YOUR_TOKEN"```

## UI
### For UI automation I took Robotframework and made a scenario the old way
So you should get 

1. Python 3.6 or newer
2. pip install robotframework
3. pip install --upgrade robotframework-seleniumlibrary
4. chromedriver (+PATH)

And then it should be a matter of running

```python -m robot basket.robot```
