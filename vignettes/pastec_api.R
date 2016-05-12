## ----pastec_server-------------------------------------------------------
library(PastecR)

# open_pastec_server defaults to the same port defaults as Pastec
ops <- open_pastec_server(url = "localhost", port = 4212)

# You can find the index_id and auth_key for your api.pastec.io account at
# <https://api.pastec.io/manager/apiPage>
hps <- hosted_pastec_server(index_id = "XXXXXXXXXXXXXXXXXXXX", auth_key = "XXXXXXXXXXXXXXXXXXXX")

