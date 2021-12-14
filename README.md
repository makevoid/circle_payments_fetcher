# Circle payments fetcher

Batch fetcher for Circle payment information

give it a list of ids and return all the payment info associated with the IDs in a single YML file

### Prerequisites:

- Docker installed

### Setup:

- create a `./data` directory 
- place a `circle_payment_ids.txt` files containing a list of newline separated Circle payment ids

### Run:

    docker run -e CIRCLE_API_KEY=<API_KEY> -v data:/app/data makevoid/circle_payments > payments.yml

Replace `<API_KEY>` with your cirle API key

The command will create a `payments.yml` file containing all the info for each Circle payment


---

Enjoy,

@makevoid
