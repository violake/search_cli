# Mockdata Search CLI
This is a search CLI which implemented by ruby, includes fake user data

## How to Run

### in local

#### prerequisites

- ruby 3.4.2 installed
#### install gems

```bash
bundle install
```

#### start search cli
```bash
./scripts/start_search.rb
```


### in Docker

#### prerequisites

- docker installed

#### start search cli

```bash
docker build -t client-search .
docker run --rm -it --name client-search-app client-search

```

## How to use this cli

```bash
=================================================================================================================
Welcome to Search CLI
Type 'quit' to exit at any time, 'next' to start a new search, 'help' for command list, Press 'Enter' to continue
=================================================================================================================

  Select search options
    * Press 1 to search
    * Press 2 to view a list of searchable fields
```

<a id="step-1"></a>1. Press 1 to start search value of a field or check duplication of a field. 2 to show searchable fields

```bash
>1
Start to search. Please choose a field from [:full_name]. 
```

2. choose the field to query

```bash
Start to search. Please choose a field from [:full_name]. 
>full_name
Enter search value or 'check' to find duplication
```

3. 'check' the duplication of this field

```bash
Enter search value or 'check' to find duplication
>check
No record found
try another value? or type 'next' to start a new search
```

4. search value of this field
```bash
try another value? or type 'next' to start a new search
>so
{id: 3, full_name: "Alex Johnson", email: "alex.johnson@hotmail.com"}
{id: 8, full_name: "James Wilson", email: "james.wilson@yandex.com"}
{id: 11, full_name: "Sophia Garcia", email: "sophia.garcia@zoho.com"}
try another value? or type 'next' to start a new search
```

5. New search start from [step 1](#step-1)