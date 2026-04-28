questa è la codebase per celebrare questo update

Oauth V2 is a comprehensive OAuth management API that allows developers to securely create, manage, and monitor tokens for accessing Openapi API services, using granular permissions based on scopes.

Here are the core features:

Token lifecycle management: Creation, update, detail retrieval, and deletion of unused tokens.
Scope control: Ability to inspect enabled scopes for your account, viewing details of permitted domains and endpoints.
Basic credit monitoring: Check the current available balance via the dedicated wallet endpoint.
Compared to the previous version, Oauth V2 introduces several new features and advanced functionalities:

Granular token limits: During creation or update, it is now possible to set specific restrictions for each token, including total request limits, number of paid requests, maximum amount deductible from the wallet, and IP whitelisting.
Secure rotation (Refresh-token): The PATCH method now natively supports the refresh-token flow, allowing for secure access key rotation.
Transaction history: In addition to viewing the remaining credit, the /wallet/transactions endpoint allows you to inspect the history of the latest wallet transactions with pagination support.
Advanced statistics (Stats): Replacing the old "counters," the new /stats endpoints offer much deeper metrics; they provide access to aggregated data, showing not only global usage but also unique IP address lists and detailed analysis per individual API domain.
Error, Callback, and Subscription monitoring: New monitoring endpoints have been introduced to inspect integration error logs (/errors), analyze callback deliveries (/callbacks), and verify the status of active subscriptions (/subscriptions).



Il sistema OAuth di Openapi si evolve con funzionalità avanzate che permettono di creare token non solo limitati nel tempo, ma anche per numero massimo di richieste, utilizzo su wallet o abbonamento, spesa massima e IP autorizzati. È ora disponibile anche il refresh token, che consente di prorogare la scadenza mantenendo limiti e consumi già maturati, eliminando automaticamente il precedente. A questo si aggiungono statistiche dettagliate su utilizzo, IP e singole API, oltre a nuove informazioni su scope, rate limit, callback, errori, wallet e transazioni, con una gestione ottimizzata per importi inferiori a 1€.


All the knowledge you need
Here you can find some advice to consider to approach this API. If you prefer, we provide code samples, OAS3 documentation, the ability to try the API live via the Swagger UI or import the entire collection into Postman. We also offer a Sandbox environment where you can experiment with all kinds of requests completely free of charge.

Useful tips to start with Oauth V2
Get the token in the appropriate section before you start.
Use the the online tool or generate it via API. Set the expire date, a usefull name and now add a bunch of scopes to limit the possible actions your token can do.

1) Create your first token.
   Create a token with one or more scopes to authorize downstream API calls. You can set name, TTL and limits (total requests, paid requests, wallet amount and IP whitelist).

2) Manage token lifecycle.
   After creation, retrieve token details, update scopes/limits/TTL and remove unused tokens. PATCH supports the refresh-token flow for secure token rotation.

3) Check available scopes.
   Retrieve the scopes enabled for your account and inspect scope details, including domain, endpoint and requirements.

4) Monitor wallet and transactions.
   Use wallet endpoints to get your current credit and inspect the latest wallet transactions with pagination support.

5) Read usage statistics.
   Access aggregate usage data for requests, paid calls and errors. You can inspect totals, IP lists and per-domain API metrics.

6) Inspect callbacks, subscriptions and errors.
   Use monitoring endpoints to troubleshoot callback deliveries, verify active subscriptions and review integration errors.



API Reference
Openapi OAuth Service
API Version: 2.1.0
Comprehensive OAuth management API that enables developers to create, manage, and monitor OAuth tokens with
granular scope-based permissions. Features include token lifecycle management, usage statistics tracking, walletbased billing, subscription handling, callback monitoring, and detailed analytics across multiple API domains.
CONTACT
NAME: Support
URL: https://openapi.it/en/support
Terms of service: https://openapi.it/en/terms-and-conditions
1 of 22
INDEX
1. CALLBACKS 4
   1.1 GET /callbacks 4
   1.2 GET /callbacks/{id} 5
2. ERRORS 7
   2.1 GET /errors 7
3. SCOPES 8
   3.1 GET /scopes 8
   3.2 GET /scopes/{id} 8
4. STATS 10
   4.1 GET /stats 10
   4.2 GET /stats/ips 10
   4.3 GET /stats/apis 11
   4.4 GET /stats/apis/{domain} 11
5. SUBSCRIPTIONS 13
   5.1 GET /subscriptions 13
   5.2 GET /subscriptions/{id} 14
6. TOKENS 15
   6.1 GET /tokens 15
   6.2 POST /tokens 16
   6.3 GET /tokens/{token} 17
   6.4 DELETE /tokens/{token} 18
   6.5 PATCH /tokens/{token} 19
7. WALLET 21
   7.1 GET /wallet 21
   7.2 GET /wallet/transactions 21
   2 of 22
   Security and Authentication
   SECURITY SCHEMES
   KEY TYPE DESCRIPTION
   BasicAuthentication
   http,
   basic
   Basic authentication with EMAIL and APIKEY. Use the API key as
   the password and the email associated with the API key as the
   username in the Authorization header.
   RefreshAuthentication
   http,
   bearer
   Bearer token authentication. Use a refresh token as the Bearer
   token in the Authorization header only for PATCH /tokens/{id}
   endpoint to update a token using its refresh token instead of the
   access token.
   3 of 22
   API
1. CALLBACKS
   Operations related to OAuth callbacks
   1.1 GET /callbacks
   List callbacks or get callback by ID
   REQUEST
   QUERY PARAMETERS
   NAME TYPE DESCRIPTION
   scopes string Comma-separated list of scopes to filter callbacks
   skip integer Number of callbacks to skip for pagination
   limit integer
   <=100
   Maximum number of callbacks to return
   RESPONSE
   STATUS CODE - 200: Callback(s) info
   RESPONSE MODEL - application/json
   {
   data
   ONE OF
   0 {
   ::props {
   Simplified callback information for list view
   id string Callback unique identifier
   scope string Scope that triggered this callback
   url string Callback destination URL
   httpResponseCode string HTTP response code received from the callback URL
   startedAt string Callback execution start time
   completedAt string Callback execution completion time (null if still active)
   }
   }
   OPTION 1{
   id string Callback unique identifier
   scope string Scope that triggered this callback
   domain string API domain for this callback
   active boolean Whether the callback is still active (not completed)
   startedAt string Callback execution start time
   createdAt string Callback creation time
   completedAt string Callback execution completion time
   httpResponseCode integer HTTP response code received from the callback URL
   data {
   Callback payload data
   }
   custom undefined Custom data associated with the callback
   headers {
   HTTP headers sent with the callback
   4 of 22
   }
   elapsedTime integer Callback execution time in milliseconds
   attempt integer Current attempt number
   retry integer Number of retries performed
   field string Field identifier for the callback
   method string HTTP method used for the callback
   url string Callback destination URL
   }
   }
   STATUS CODE - 400: Query error
   RESPONSE MODEL - application/json
   STATUS CODE - 404: Callback not found
   RESPONSE MODEL - application/json
   1.2 GET /callbacks/{id}
   Get callback by ID
   REQUEST
   PATH PARAMETERS
   NAME TYPE DESCRIPTION
   *id string Callback ID
   RESPONSE
   STATUS CODE - 200: Callback detail
   RESPONSE MODEL - application/json
   {
   data {
   Complete callback information
   id string Callback unique identifier
   scope string Scope that triggered this callback
   domain string API domain for this callback
   active boolean Whether the callback is still active (not completed)
   startedAt string Callback execution start time
   createdAt string Callback creation time
   completedAt string Callback execution completion time
   httpResponseCode integer HTTP response code received from the callback URL
   data {
   Callback payload data
   }
   custom undefined Custom data associated with the callback
   headers {
   HTTP headers sent with the callback
   }
   elapsedTime integer Callback execution time in milliseconds
   attempt integer Current attempt number
   retry integer Number of retries performed
   field string Field identifier for the callback
   method string HTTP method used for the callback
   5 of 22
   url string Callback destination URL
   }
   }
   STATUS CODE - 404: Callback not found
   RESPONSE MODEL - application/json
   6 of 22
2. ERRORS
   Operations related to API errors
   2.1 GET /errors
   List error logs
   REQUEST
   QUERY PARAMETERS
   NAME TYPE DESCRIPTION
   scopes string Comma-separated list of scopes to filter errors
   skip integer Number of errors to skip for pagination
   limit integer
   <=100
   Maximum number of errors to return
   RESPONSE
   STATUS CODE - 200: List of error logs
   RESPONSE MODEL - application/json
   {
   data [{
   Array of object: Error log entry
   id string Error log unique identifier
   scope string Scope that caused the error
   domain string API domain where the error occurred
   errorAt string Timestamp when the error occurred
   httpResponseCode integer HTTP response status code
   errorCode number Internal error code
   message string Error message
   ip string IP address that triggered the error
   }]
   }
   STATUS CODE - 400: Query error
   RESPONSE MODEL - application/json
   7 of 22
3. SCOPES
   Operations related to OAuth scopes
   3.1 GET /scopes
   List of available scopes
   REQUEST
   No request parameters
   RESPONSE
   STATUS CODE - 200: List of scopes
   RESPONSE MODEL - application/json
   {
   data [{
   Array of object: Basic scope information available in list view
   id string Scope unique identifier
   scope string Scope name
   method string HTTP method
   endpoint string Associated endpoint
   domain string Associated domain
   enabled boolean Whether this scope is enabled for the authenticated user
   }]
   }
   3.2 GET /scopes/{id}
   Get scope by ID
   REQUEST
   PATH PARAMETERS
   NAME TYPE DESCRIPTION
   *id string Scope ID
   RESPONSE
   STATUS CODE - 200: Scope detail
   RESPONSE MODEL - application/json
   {
   data* {
   Detailed scope information including limits, requirements and pricing
   id string Scope unique identifier
   scope string Scope name
   method string HTTP method
   endpoint string Associated endpoint
   domain string Associated domain
   enabled boolean Whether this scope is enabled for the authenticated user
   rateLimit
   8 of 22
   ONE OF
   prop0
   string
   prop1
   boolean
   freeLimits
   {
   Free usage limits for a scope
   dayLimit
   ONE OF
   prop0
   integer
   prop1
   boolean
   monthLimit
   ONE OF
   prop0
   integer
   prop1
   boolean
   yearLimit
   ONE OF
   prop0
   integer
   prop1
   boolean
   totalLimit
   ONE OF
   prop0
   integer
   prop1
   boolean
   }
   requirements
   {
   Requirements for this scope with their fulfillment status }
   prices
   {
   Pricing information for this scope by price key }
   }
   success* boolean
   message* string
   error* undefined
   }
   STATUS CODE - 404: Scope not found
   RESPONSE MODEL - application/json
   9 of 22
4. STATS
   Operations related to API usage statistics
   4.1 GET /stats
   Get overall API usage stats
   REQUEST
   QUERY PARAMETERS
   NAME TYPE DESCRIPTION
   date date Date filter
   RESPONSE
   STATUS CODE - 200: Overall stats info
   RESPONSE MODEL - application/json
   {
   data {
   totalRequests number Total number of requests
   walletRequests number Number of paid wallet requests
   subscriptionRequests number Number of subscription requests
   errorRequests number Number of error requests
   walletAmount number Total amount spent via wallet
   totalIps integer Total number of unique IP addresses
   totalApis integer Total number of APIs used
   }
   }
   STATUS CODE - 422: Invalid date format
   RESPONSE MODEL - application/json
   4.2 GET /stats/ips
   Get list of unique IP addresses
   REQUEST
   QUERY PARAMETERS
   NAME TYPE DESCRIPTION
   date string Date filter (YYYY or YYYY-MM or YYYY-MM-DD)
   RESPONSE
   STATUS CODE - 200: Array of unique IP addresses
   RESPONSE MODEL - application/json
   {
   data [string]
   10 of 22
   }
   STATUS CODE - 422: Invalid date format
   RESPONSE MODEL - application/json
   4.3 GET /stats/apis
   Get stats grouped by API domain
   REQUEST
   QUERY PARAMETERS
   NAME TYPE DESCRIPTION
   date string Date filter (YYYY or YYYY-MM or YYYY-MM-DD)
   RESPONSE
   STATUS CODE - 200: Stats grouped by API domain
   RESPONSE MODEL - application/json
   {
   data {
   Object where each key is an API domain and value contains stats for that domain
   }
   }
   STATUS CODE - 422: Invalid date format
   RESPONSE MODEL - application/json
   4.4 GET /stats/apis/{domain}
   Get detailed stats for a specific API domain including scopes breakdown
   REQUEST
   PATH PARAMETERS
   NAME TYPE DESCRIPTION
   *domain string API domain name
   QUERY PARAMETERS
   NAME TYPE DESCRIPTION
   date string Date filter (YYYY or YYYY-MM or YYYY-MM-DD)
   RESPONSE
   STATUS CODE - 200: Domain-specific stats with scopes breakdown
   RESPONSE MODEL - application/json
   {
   data {
   11 of 22
   totalRequests number Total number of requests for this domain
   walletRequests number Number of paid wallet requests for this domain
   subscriptionRequests number Number of subscription requests for this domain
   errorRequests number Number of error requests for this domain
   walletAmount number Total amount spent via wallet for this domain
   ip [string]
   totalIps integer Number of unique IP addresses for this domain
   totalScopes integer Number of scopes for this domain
   scopes {
   Object where each key is a scope identifier and value contains stats for that scope
   }
   }
   }
   STATUS CODE - 422: Invalid date format
   RESPONSE MODEL - application/json
   12 of 22
5. SUBSCRIPTIONS
   Operations related to subscriptions
   5.1 GET /subscriptions
   List subscriptions or get subscription by ID
   REQUEST
   QUERY PARAMETERS
   NAME TYPE DESCRIPTION
   id string Subscription ID to retrieve specific subscription
   scopes string Comma-separated list of scopes to filter subscriptions
   skip integer Number of subscriptions to skip for pagination
   limit integer
   <=100
   Maximum number of subscriptions to return
   RESPONSE
   STATUS CODE - 200: Subscription(s) info
   RESPONSE MODEL - application/json
   {
   data
   ONE OF
   0 {
   ::props {
   Simplified subscription information for list view
   id string Subscription unique identifier
   scope string Scope this subscription applies to
   active boolean Whether the subscription is currently active
   availableRequests string Number of requests available in this subscription
   startsAt string Subscription start date
   expiresAt string Subscription expiration date
   }
   }
   OPTION 1{
   id string Subscription unique identifier
   scope string Scope this subscription applies to
   domain string API domain for this subscription
   active boolean Whether the subscription is currently active
   startsAt string Subscription start date
   expiresAt string Subscription expiration date
   totalRequests string Total number of requests originally included in this subscription
   availableRequests string Number of requests still available in this subscription
   pricePerRequest number Price per request for this subscription
   type string Subscription type (e.g., month, year)
   autorenew boolean Whether the subscription will automatically renew
   createdAt string Subscription creation date
   updatedAt string Last update date
   price number Total price of the subscription
   }
   13 of 22
   }
   STATUS CODE - 400: Query error
   RESPONSE MODEL - application/json
   STATUS CODE - 404: Subscription not found
   RESPONSE MODEL - application/json
   5.2 GET /subscriptions/{id}
   Get subscription by ID
   REQUEST
   PATH PARAMETERS
   NAME TYPE DESCRIPTION
   *id string Subscription ID
   RESPONSE
   STATUS CODE - 200: Subscription detail
   RESPONSE MODEL - application/json
   {
   data {
   Complete subscription information
   id string Subscription unique identifier
   scope string Scope this subscription applies to
   domain string API domain for this subscription
   active boolean Whether the subscription is currently active
   startsAt string Subscription start date
   expiresAt string Subscription expiration date
   totalRequests string Total number of requests originally included in this subscription
   availableRequests string Number of requests still available in this subscription
   pricePerRequest number Price per request for this subscription
   type string Subscription type (e.g., month, year)
   autorenew boolean Whether the subscription will automatically renew
   createdAt string Subscription creation date
   updatedAt string Last update date
   price number Total price of the subscription
   }
   }
   STATUS CODE - 404: Subscription not found
   RESPONSE MODEL - application/json
   14 of 22
6. TOKENS
   Operations related to OAuth tokens
   6.1 GET /tokens
   List or token detail
   REQUEST
   QUERY PARAMETERS
   NAME TYPE DESCRIPTION
   limit integer
   <=100
   Maximum number of tokens to return (default 100, max 100)
   skip integer Number of tokens to skip for pagination (default 0)
   RESPONSE
   STATUS CODE - 200: List or token detail
   RESPONSE MODEL - application/json
   {
   data
   ONE OF
   0 {
   ::props {
   token string Unique token identifier
   name string Human readable token name
   createdAt string Creation timestamp
   expireAt string Expiration timestamp
   updatedAt string Last update timestamp
   scopes [string]
   refreshToken string Associated refresh token. Is used to extend the token's TTL
   limits {
   Usage limits associated with the token
   totalRequests integer Maximum number of total allowed requests
   walletRequests integer Maximum number of paid wallet requests allowed
   subscriptionRequests integer Maximum number of subscription requests allowed
   walletAmount number Maximum amount usable from the associated wallet
   ip [string]
   }
   stats {
   Usage statistics for the token
   totalRequests integer Total number of requests made
   walletRequests integer Number of paid wallet requests made
   subscriptionRequests integer Number of subscription requests made
   errorRequests integer Number of requests that resulted in an error
   walletAmount number Total amount spent via wallet
   ip [string]
   }
   }
   }
   OPTION 1{
   token string Unique token identifier
   15 of 22
   name string Human readable token name
   createdAt string Creation timestamp
   expireAt string Expiration timestamp
   updatedAt string Last update timestamp
   scopes [string]
   refreshToken string Associated refresh token. Is used to extend the token's TTL
   limits {
   Usage limits associated with the token
   totalRequests integer Maximum number of total allowed requests
   walletRequests integer Maximum number of paid wallet requests allowed
   subscriptionRequests integer Maximum number of subscription requests allowed
   walletAmount number Maximum amount usable from the associated wallet
   ip [string]
   }
   stats {
   Usage statistics for the token
   totalRequests integer Total number of requests made
   walletRequests integer Number of paid wallet requests made
   subscriptionRequests integer Number of subscription requests made
   errorRequests integer Number of requests that resulted in an error
   walletAmount number Total amount spent via wallet
   ip [string]
   }
   }
   }
   STATUS CODE - 404: Token not found
   RESPONSE MODEL - application/json
   STATUS CODE - 422: Validation error
   RESPONSE MODEL - application/json
   6.2 POST /tokens
   Create a new token
   REQUEST
   REQUEST BODY - application/json
   {
   Data to create a new token
   scopes* [string]
   name string Human-readable token name
   ttl integer Token lifetime in seconds. Max 1 year. If a negative value or 0 is provided, the value is automatically clamped to
   the default TTL.
   limits {
   Usage limits associated with the token
   totalRequests integer Maximum number of total allowed requests
   walletRequests integer Maximum number of paid wallet requests allowed
   subscriptionRequests integer Maximum number of subscription requests allowed
   walletAmount number Maximum amount usable from the associated wallet
   ip [string]
   }
   }
   RESPONSE
   16 of 22
   STATUS CODE - 200: Token created
   RESPONSE MODEL - application/json
   {
   token string Unique token identifier
   name string Human readable token name
   createdAt string Creation timestamp
   expireAt string Expiration timestamp
   updatedAt string Last update timestamp
   scopes [string]
   refreshToken string Associated refresh token. Is used to extend the token's TTL
   limits {
   Usage limits associated with the token
   totalRequests integer Maximum number of total allowed requests
   walletRequests integer Maximum number of paid wallet requests allowed
   subscriptionRequests integer Maximum number of subscription requests allowed
   walletAmount number Maximum amount usable from the associated wallet
   ip [string]
   }
   stats {
   Usage statistics for the token
   totalRequests integer Total number of requests made
   walletRequests integer Number of paid wallet requests made
   subscriptionRequests integer Number of subscription requests made
   errorRequests integer Number of requests that resulted in an error
   walletAmount number Total amount spent via wallet
   ip [string]
   }
   }
   STATUS CODE - 422: Validation error
   RESPONSE MODEL - application/json
   6.3 GET /tokens/{token}
   Get token by ID
   REQUEST
   PATH PARAMETERS
   NAME TYPE DESCRIPTION
   *token string Token identifier
   RESPONSE
   STATUS CODE - 200: Token detail
   RESPONSE MODEL - application/json
   {
   token string Unique token identifier
   name string Human readable token name
   createdAt string Creation timestamp
   expireAt string Expiration timestamp
   updatedAt string Last update timestamp
   scopes [string]
   17 of 22
   refreshToken string Associated refresh token. Is used to extend the token's TTL
   limits {
   Usage limits associated with the token
   totalRequests integer Maximum number of total allowed requests
   walletRequests integer Maximum number of paid wallet requests allowed
   subscriptionRequests integer Maximum number of subscription requests allowed
   walletAmount number Maximum amount usable from the associated wallet
   ip [string]
   }
   stats {
   Usage statistics for the token
   totalRequests integer Total number of requests made
   walletRequests integer Number of paid wallet requests made
   subscriptionRequests integer Number of subscription requests made
   errorRequests integer Number of requests that resulted in an error
   walletAmount number Total amount spent via wallet
   ip [string]
   }
   }
   STATUS CODE - 404: Token not found
   RESPONSE MODEL - application/json
   STATUS CODE - 422: Validation error
   RESPONSE MODEL - application/json
   6.4 DELETE /tokens/{token}
   Delete token by ID
   REQUEST
   PATH PARAMETERS
   NAME TYPE DESCRIPTION
   *token string Token identifier
   RESPONSE
   STATUS CODE - 200: Token deleted successfully
   RESPONSE MODEL - application/json
   {
   message string
   data undefined
   }
   STATUS CODE - 400: Bad request
   RESPONSE MODEL - application/json
   STATUS CODE - 404: Token not found
   RESPONSE MODEL - application/json
   18 of 22
   6.5 PATCH /tokens/{token}
   Update token by ID
   REQUEST
   PATH PARAMETERS
   NAME TYPE DESCRIPTION
   *token string Token identifier
   REQUEST BODY - application/json
   {
   Data to update an existing token. Authentication may use a Bearer access token or, alternatively, a refresh token passed as the Bearer token in the
   Authorization header. When using a refresh token, a new token and a new refresh token with the same scopes are returned, and the previous token is
   deleted.
   scopes [string]
   name string New token name
   ttl integer New lifetime in seconds
   limits {
   Usage limits associated with the token
   totalRequests integer Maximum number of total allowed requests
   walletRequests integer Maximum number of paid wallet requests allowed
   subscriptionRequests integer Maximum number of subscription requests allowed
   walletAmount number Maximum amount usable from the associated wallet
   ip [string]
   }
   }
   RESPONSE
   STATUS CODE - 200: Token updated
   RESPONSE MODEL - application/json
   {
   token string Unique token identifier
   name string Human readable token name
   createdAt string Creation timestamp
   expireAt string Expiration timestamp
   updatedAt string Last update timestamp
   scopes [string]
   refreshToken string Associated refresh token. Is used to extend the token's TTL
   limits {
   Usage limits associated with the token
   totalRequests integer Maximum number of total allowed requests
   walletRequests integer Maximum number of paid wallet requests allowed
   subscriptionRequests integer Maximum number of subscription requests allowed
   walletAmount number Maximum amount usable from the associated wallet
   ip [string]
   }
   stats {
   Usage statistics for the token
   totalRequests integer Total number of requests made
   walletRequests integer Number of paid wallet requests made
   subscriptionRequests integer Number of subscription requests made
   errorRequests integer Number of requests that resulted in an error
   walletAmount number Total amount spent via wallet
   ip [string]
   19 of 22
   }
   }
   STATUS CODE - 400: Bad request
   RESPONSE MODEL - application/json
   STATUS CODE - 401: Unauthorized
   RESPONSE MODEL - application/json
   STATUS CODE - 404: Token not found
   RESPONSE MODEL - application/json
   STATUS CODE - 422: Validation error
   RESPONSE MODEL - application/json
   20 of 22
7. WALLET
   Operations related to the wallet associated with tokens
   7.1 GET /wallet
   Get wallet information
   REQUEST
   No request parameters
   RESPONSE
   STATUS CODE - 200: Wallet information
   RESPONSE MODEL - application/json
   {
   data {
   Wallet information
   credit number Current wallet credit balance
   createdAt string Wallet creation date
   updatedAt string Last wallet update date
   }
   }
   7.2 GET /wallet/transactions
   Get wallet transactions history
   REQUEST
   QUERY PARAMETERS
   NAME TYPE DESCRIPTION
   skip integer Number of transactions to skip for pagination
   limit integer
   <=100
   Maximum number of transactions to return
   RESPONSE
   STATUS CODE - 200: List of wallet transactions
   RESPONSE MODEL - application/json
   {
   data [{
   Array of object: Wallet transaction entry
   id string Transaction unique identifier
   amount number Transaction amount (negative for expenses, positive for credits)
   createdAt string Transaction timestamp
   description string Transaction description
   }]
   }
   21 of 22
   22 of 22


{"openapi":"3.0.0","info":{"title":"Openapi OAuth Service","version":"2.1.0","description":"Comprehensive OAuth management API that enables developers to create, manage, and monitor OAuth tokens with granular scope-based permissions. Features include token lifecycle management, usage statistics tracking, wallet-based billing, subscription handling, callback monitoring, and detailed analytics across multiple API domains.","contact":{"url":"https://openapi.it/en/support","name":"Support"},"termsOfService":"https://openapi.it/en/terms-and-conditions"},"servers":[{"url":"https://oauth.openapi.com","description":"Production"},{"url":"https://test.oauth.openapi.com","description":"Sandbox"}],"tags":[{"name":"Tokens","description":"Operations related to OAuth tokens"},{"name":"Scopes","description":"Operations related to OAuth scopes"},{"name":"Callbacks","description":"Operations related to OAuth callbacks"},{"name":"Errors","description":"Operations related to API errors"},{"name":"Wallet","description":"Operations related to the wallet associated with tokens"},{"name":"Stats","description":"Operations related to API usage statistics"},{"name":"Subscriptions","description":"Operations related to subscriptions"}],"paths":{"/tokens":{"post":{"summary":"Create a new token","tags":["Tokens"],"requestBody":{"required":true,"content":{"application/json":{"schema":{"$ref":"#/components/schemas/TokenCreate"}}}},"responses":{"200":{"description":"Token created","content":{"application/json":{"schema":{"$ref":"#/components/schemas/TokenDetail"}}}},"422":{"description":"Validation error","content":{"application/json":{"examples":{"missing_scopes":{"summary":"missing scopes array","value":{"success":false,"message":"missing scopes array","error":70,"data":null}},"invalid_scopes_format":{"summary":"invalid scopes format","value":{"success":false,"message":"invalid scopes format","error":80,"data":null}},"invalid_scopes":{"summary":"Invalid scopes specified or API not enabled","value":{"success":false,"message":"Invalid scopes specified or API not enabled","error":90,"data":null}}}}}}},"security":[{"Basic-Authentication":[]}]},"get":{"summary":"List or token detail","tags":["Tokens"],"parameters":[{"name":"limit","in":"query","description":"Maximum number of tokens to return (default 100, max 100)","required":false,"schema":{"type":"integer","default":100,"maximum":100}},{"name":"skip","in":"query","description":"Number of tokens to skip for pagination (default 0)","required":false,"schema":{"type":"integer","default":0}}],"responses":{"200":{"description":"List or token detail","content":{"application/json":{"schema":{"$ref":"#/components/schemas/TokenListOrDetail"}}}},"404":{"description":"Token not found","content":{"application/json":{"example":{"success":false,"message":"Not Found","error":120,"data":null}}}},"422":{"description":"Validation error","content":{"application/json":{"example":{"success":false,"message":"Invalid Token Format","error":60,"data":null}}}}},"security":[{"Basic-Authentication":[]}]}},"/scopes":{"get":{"summary":"List of available scopes","tags":["Scopes"],"responses":{"200":{"description":"List of scopes","content":{"application/json":{"schema":{"type":"object","properties":{"data":{"type":"array","items":{"$ref":"#/components/schemas/UserScope"}}}}}}}},"security":[{"Basic-Authentication":[]}]}},"/tokens/{token}":{"get":{"summary":"Get token by ID","tags":["Tokens"],"parameters":[{"name":"token","in":"path","required":true,"schema":{"type":"string"},"description":"Token identifier"}],"responses":{"200":{"description":"Token detail","content":{"application/json":{"schema":{"$ref":"#/components/schemas/TokenDetail"}}}},"404":{"description":"Token not found","content":{"application/json":{"example":{"success":false,"message":"Not Found","error":120,"data":null}}}},"422":{"description":"Validation error","content":{"application/json":{"example":{"success":false,"message":"Invalid Token Format","error":60,"data":null}}}}},"security":[{"Basic-Authentication":[]}]},"patch":{"summary":"Update token by ID","tags":["Tokens"],"parameters":[{"name":"token","in":"path","required":true,"schema":{"type":"string"},"description":"Token identifier"}],"requestBody":{"required":true,"content":{"application/json":{"schema":{"$ref":"#/components/schemas/TokenUpdate"}}}},"responses":{"200":{"description":"Token updated","content":{"application/json":{"schema":{"$ref":"#/components/schemas/TokenDetail"}}}},"400":{"description":"Bad request","content":{"application/json":{"examples":{"token_id_required":{"summary":"Token ID is required","value":{"success":false,"message":"Token ID is required","error":150,"data":null}}}}}},"401":{"description":"Unauthorized","content":{"application/json":{"examples":{"unauthorized_refresh":{"summary":"Unauthorized","value":{"success":false,"message":"Unauthorized","error":130,"data":null}},"unauthorized_authdata":{"summary":"Unauthorized","value":{"success":false,"message":"Unauthorized","error":140,"data":null}}}}}},"404":{"description":"Token not found","content":{"application/json":{"example":{"success":false,"message":"Not Found","error":160,"data":null}}}},"422":{"description":"Validation error","content":{"application/json":{"examples":{"invalid_scopes_format":{"summary":"invalid scopes format","value":{"success":false,"message":"invalid scopes format","error":100,"data":null}},"invalid_scopes":{"summary":"Invalid scopes specified or API not enabled","value":{"success":false,"message":"Invalid scopes specified or API not enabled","error":110,"data":null}}}}}}},"security":[{"Basic-Authentication":[]},{"Refresh-Authentication":[]}]},"delete":{"summary":"Delete token by ID","tags":["Tokens"],"parameters":[{"name":"token","in":"path","required":true,"schema":{"type":"string"},"description":"Token identifier"}],"responses":{"200":{"description":"Token deleted successfully","content":{"application/json":{"schema":{"type":"object","properties":{"message":{"type":"string","example":"Deleted"},"data":{"nullable":true}}}}}},"400":{"description":"Bad request","content":{"application/json":{"example":{"success":false,"message":"Token ID is required","error":170,"data":null}}}},"404":{"description":"Token not found","content":{"application/json":{"example":{"success":false,"message":"Not Found","error":180,"data":null}}}}},"security":[{"Basic-Authentication":[]}]}},"/errors":{"get":{"summary":"List error logs","tags":["Errors"],"parameters":[{"name":"scopes","in":"query","required":false,"schema":{"type":"string"},"description":"Comma-separated list of scopes to filter errors"},{"name":"skip","in":"query","required":false,"schema":{"type":"integer","default":0},"description":"Number of errors to skip for pagination"},{"name":"limit","in":"query","required":false,"schema":{"type":"integer","default":100,"maximum":100},"description":"Maximum number of errors to return"}],"responses":{"200":{"description":"List of error logs","content":{"application/json":{"schema":{"type":"object","properties":{"data":{"type":"array","items":{"$ref":"#/components/schemas/ErrorLog"}}}},"example":{"data":[{"id":"69822d1d48be79971b04351a","scope":"DELETE:oauth.openapi.com/tokens","domain":"oauth.openapi.com","errorAt":"2026-02-03T17:15:09+00:00","httpResponseCode":404,"errorCode":180,"message":"Not Found","ip":"93.146.69.125"},{"id":"69822d1d48be79971b04351b","scope":"GET:company.openapi.com/resource","domain":"company.openapi.com","errorAt":"2026-02-03T16:30:45+00:00","httpResponseCode":400,"errorCode":190,"message":"Query error","ip":"192.168.1.100"}]}}}},"400":{"description":"Query error","content":{"application/json":{"example":{"success":false,"message":"Query error","error":190,"data":null}}}}},"security":[{"Basic-Authentication":[]}]}},"/wallet":{"get":{"summary":"Get wallet information","tags":["Wallet"],"responses":{"200":{"description":"Wallet information","content":{"application/json":{"schema":{"type":"object","properties":{"data":{"$ref":"#/components/schemas/Wallet"}}},"example":{"data":{"credit":125.5,"createdAt":"2025-01-15T10:00:00+00:00","updatedAt":"2026-02-12T08:30:00+00:00"}}}}}},"security":[{"Basic-Authentication":[]}]}},"/callbacks":{"get":{"summary":"List callbacks or get callback by ID","tags":["Callbacks"],"parameters":[{"name":"scopes","in":"query","required":false,"schema":{"type":"string"},"description":"Comma-separated list of scopes to filter callbacks"},{"name":"skip","in":"query","required":false,"schema":{"type":"integer","default":0},"description":"Number of callbacks to skip for pagination"},{"name":"limit","in":"query","required":false,"schema":{"type":"integer","default":100,"maximum":100},"description":"Maximum number of callbacks to return"}],"responses":{"200":{"description":"Callback(s) info","content":{"application/json":{"schema":{"type":"object","properties":{"data":{"oneOf":[{"type":"array","items":{"$ref":"#/components/schemas/CallbackListElement"}},{"$ref":"#/components/schemas/Callback"}]}}},"examples":{"list":{"summary":"List of callbacks","value":{"data":[{"id":"65a1b2c3d4e5f6789abcdef0","scope":"POST:company.openapi.com/webhook","url":"https://example.com/callback","httpResponseCode":"200","startedAt":"2026-02-12T10:00:00+00:00","completedAt":"2026-02-12T10:00:05+00:00"},{"id":"65a1b2c3d4e5f6789abcdef1","scope":"POST:sms.openapi.com/send","url":"https://app.example.com/notify","httpResponseCode":"200","startedAt":"2026-02-12T09:30:00+00:00","completedAt":null}]}},"detail":{"summary":"Single callback detail","value":{"data":{"id":"65a1b2c3d4e5f6789abcdef0","scope":"POST:company.openapi.com/webhook","domain":"company.openapi.com","active":false,"startedAt":"2026-02-12T10:00:00+00:00","createdAt":"2026-02-12T09:59:55+00:00","completedAt":"2026-02-12T10:00:05+00:00","httpResponseCode":200,"data":{"event":"user.created","userId":"12345"},"custom":{"trackingId":"abc-123"},"headers":{"Content-Type":"application/json","X-Webhook-Signature":"sha256=..."},"elapsedTime":5234,"attempt":1,"retry":0,"field":"webhookUrl","method":"POST","url":"https://example.com/callback"}}}}}}},"400":{"description":"Query error","content":{"application/json":{"example":{"success":false,"message":"Query error","error":210,"data":null}}}},"404":{"description":"Callback not found","content":{"application/json":{"example":{"success":false,"message":"Callback not found","error":200,"data":null}}}}},"security":[{"Basic-Authentication":[]}]}},"/stats":{"get":{"summary":"Get overall API usage stats","tags":["Stats"],"parameters":[{"name":"date","in":"query","required":false,"schema":{"type":"string","format":"date"},"description":"Date filter"}],"responses":{"200":{"description":"Overall stats info","content":{"application/json":{"schema":{"type":"object","properties":{"data":{"type":"object","properties":{"totalRequests":{"type":"number","description":"Total number of requests"},"walletRequests":{"type":"number","description":"Number of paid wallet requests"},"subscriptionRequests":{"type":"number","description":"Number of subscription requests"},"errorRequests":{"type":"number","description":"Number of error requests"},"walletAmount":{"type":"number","description":"Total amount spent via wallet"},"totalIps":{"type":"integer","description":"Total number of unique IP addresses"},"totalApis":{"type":"integer","description":"Total number of APIs used"}}}}},"example":{"data":{"totalRequests":1500,"walletRequests":800,"subscriptionRequests":700,"errorRequests":12,"walletAmount":125.5,"totalIps":45,"totalApis":8}}}}},"422":{"description":"Invalid date format","content":{"application/json":{"example":{"success":false,"message":"Invalid date format, must be YYYY or YYYY-MM or YYYY-MM-DD","error":240,"data":null}}}}},"security":[{"Basic-Authentication":[]}]}},"/stats/ips":{"get":{"summary":"Get list of unique IP addresses","tags":["Stats"],"parameters":[{"name":"date","in":"query","required":false,"schema":{"type":"string"},"description":"Date filter (YYYY or YYYY-MM or YYYY-MM-DD)"}],"responses":{"200":{"description":"Array of unique IP addresses","content":{"application/json":{"schema":{"type":"object","properties":{"data":{"type":"array","items":{"type":"string"}}}},"example":{"data":["192.168.1.1","10.0.0.5","172.16.0.100","203.0.113.42"]}}}},"422":{"description":"Invalid date format","content":{"application/json":{"example":{"success":false,"message":"Invalid date format, must be YYYY or YYYY-MM or YYYY-MM-DD","error":240,"data":null}}}}},"security":[{"Basic-Authentication":[]}]}},"/stats/apis":{"get":{"summary":"Get stats grouped by API domain","tags":["Stats"],"parameters":[{"name":"date","in":"query","required":false,"schema":{"type":"string"},"description":"Date filter (YYYY or YYYY-MM or YYYY-MM-DD)"}],"responses":{"200":{"description":"Stats grouped by API domain","content":{"application/json":{"schema":{"type":"object","properties":{"data":{"type":"object","description":"Object where each key is an API domain and value contains stats for that domain","additionalProperties":{"type":"object","properties":{"totalRequests":{"type":"number","description":"Total number of requests for this domain"},"walletRequests":{"type":"number","description":"Number of paid wallet requests for this domain"},"subscriptionRequests":{"type":"number","description":"Number of subscription requests for this domain"},"errorRequests":{"type":"number","description":"Number of error requests for this domain"},"walletAmount":{"type":"number","description":"Total amount spent via wallet for this domain"},"totalIps":{"type":"integer","description":"Number of unique IP addresses for this domain"},"totalScopes":{"type":"integer","description":"Number of scopes for this domain"}}}}}},"example":{"data":{"company.openapi.com":{"totalRequests":500,"walletRequests":300,"subscriptionRequests":200,"errorRequests":5,"walletAmount":45.5,"totalIps":20,"totalScopes":15},"sms.openapi.com":{"totalRequests":1000,"walletRequests":500,"subscriptionRequests":500,"errorRequests":7,"walletAmount":80,"totalIps":25,"totalScopes":20}}}}}},"422":{"description":"Invalid date format","content":{"application/json":{"example":{"success":false,"message":"Invalid date format, must be YYYY or YYYY-MM or YYYY-MM-DD","error":240,"data":null}}}}},"security":[{"Basic-Authentication":[]}]}},"/stats/apis/{domain}":{"get":{"summary":"Get detailed stats for a specific API domain including scopes breakdown","tags":["Stats"],"parameters":[{"name":"domain","in":"path","required":true,"schema":{"type":"string"},"description":"API domain name","example":"company.openapi.com"},{"name":"date","in":"query","required":false,"schema":{"type":"string"},"description":"Date filter (YYYY or YYYY-MM or YYYY-MM-DD)"}],"responses":{"200":{"description":"Domain-specific stats with scopes breakdown","content":{"application/json":{"schema":{"type":"object","properties":{"data":{"type":"object","properties":{"totalRequests":{"type":"number","description":"Total number of requests for this domain"},"walletRequests":{"type":"number","description":"Number of paid wallet requests for this domain"},"subscriptionRequests":{"type":"number","description":"Number of subscription requests for this domain"},"errorRequests":{"type":"number","description":"Number of error requests for this domain"},"walletAmount":{"type":"number","description":"Total amount spent via wallet for this domain"},"ip":{"type":"array","description":"Array of unique IP addresses for this domain","items":{"type":"string"}},"totalIps":{"type":"integer","description":"Number of unique IP addresses for this domain"},"totalScopes":{"type":"integer","description":"Number of scopes for this domain"},"scopes":{"type":"object","description":"Object where each key is a scope identifier and value contains stats for that scope","additionalProperties":{"type":"object","properties":{"totalRequests":{"type":"number"},"walletRequests":{"type":"number"},"subscriptionRequests":{"type":"number"},"errorRequests":{"type":"number"},"walletAmount":{"type":"number"},"ip":{"type":"array","items":{"type":"string"}}}}}}}}},"example":{"data":{"totalRequests":500,"walletRequests":300,"subscriptionRequests":200,"errorRequests":5,"walletAmount":45.5,"ip":["192.168.1.1","10.0.0.5"],"totalIps":2,"totalScopes":15,"scopes":{"POST:company.openapi.com/endpoint":{"totalRequests":250,"walletRequests":150,"subscriptionRequests":100,"errorRequests":2,"walletAmount":22.75,"ip":["192.168.1.1"]},"GET:company.openapi.com/endpoint":{"totalRequests":250,"walletRequests":150,"subscriptionRequests":100,"errorRequests":3,"walletAmount":22.75,"ip":["10.0.0.5"]}}}}}}},"422":{"description":"Invalid date format","content":{"application/json":{"example":{"success":false,"message":"Invalid date format, must be YYYY or YYYY-MM or YYYY-MM-DD","error":240,"data":null}}}}},"security":[{"Basic-Authentication":[]}]}},"/subscriptions":{"get":{"summary":"List subscriptions or get subscription by ID","tags":["Subscriptions"],"parameters":[{"name":"id","in":"query","required":false,"schema":{"type":"string"},"description":"Subscription ID to retrieve specific subscription"},{"name":"scopes","in":"query","required":false,"schema":{"type":"string"},"description":"Comma-separated list of scopes to filter subscriptions"},{"name":"skip","in":"query","required":false,"schema":{"type":"integer","default":0},"description":"Number of subscriptions to skip for pagination"},{"name":"limit","in":"query","required":false,"schema":{"type":"integer","default":100,"maximum":100},"description":"Maximum number of subscriptions to return"}],"responses":{"200":{"description":"Subscription(s) info","content":{"application/json":{"schema":{"type":"object","properties":{"data":{"oneOf":[{"type":"array","items":{"$ref":"#/components/schemas/SubscriptionListElement"}},{"$ref":"#/components/schemas/Subscription"}]}}},"examples":{"list":{"summary":"List of subscriptions","value":{"data":[{"id":"656d1e2f8b3c2a001f7e4a20","scope":"GET:company.openapi.com/resource","active":true,"availableRequests":"950","startsAt":"2025-11-01T00:00:00+00:00","expiresAt":"2025-12-01T00:00:00+00:00"},{"id":"656d1e2f8b3c2a001f7e4a21","scope":"POST:sms.openapi.com/send","active":true,"availableRequests":"800","startsAt":"2025-11-15T00:00:00+00:00","expiresAt":"2026-11-15T00:00:00+00:00"}]}},"detail":{"summary":"Single subscription detail","value":{"data":{"id":"656d1e2f8b3c2a001f7e4a20","scope":"GET:company.openapi.com/resource","domain":"company.openapi.com","active":true,"startsAt":"2025-11-01T00:00:00+00:00","expiresAt":"2025-12-01T00:00:00+00:00","totalRequests":"1000","availableRequests":"950","pricePerRequest":0.01,"type":"monthly","autorenew":true,"createdAt":"2025-10-25T10:00:00+00:00","updatedAt":"2025-11-19T15:30:00+00:00","price":10}}}}}}},"400":{"description":"Query error","content":{"application/json":{"example":{"success":false,"message":"Query error","error":230,"data":null}}}},"404":{"description":"Subscription not found","content":{"application/json":{"example":{"success":false,"message":"Subscription not found","error":220,"data":null}}}}},"security":[{"Basic-Authentication":[]}]}},"/scopes/{id}":{"get":{"summary":"Get scope by ID","tags":["Scopes"],"parameters":[{"name":"id","in":"path","required":true,"schema":{"type":"string"},"description":"Scope ID"}],"responses":{"200":{"description":"Scope detail","content":{"application/json":{"schema":{"type":"object","properties":{"data":{"$ref":"#/components/schemas/ScopeDetail"},"success":{"type":"boolean","example":true},"message":{"type":"string","example":""},"error":{"nullable":true,"example":null}},"required":["data","success","message","error"]},"example":{"data":{"id":"682c9f5a51671f7ef264c4fd","scope":"GET:company.openapi.com/CH-start","method":"GET","endpoint":"CH-start","domain":"company.openapi.com","enabled":false,"rateLimit":false,"freeLimits":{"dayLimit":0,"monthLimit":false,"yearLimit":false,"totalLimit":false},"requirements":{"id_card":false,"oa_general_contract":false},"prices":{"ch-start":0.06}},"success":true,"message":"","error":null}}}},"404":{"description":"Scope not found","content":{"application/json":{"example":{"success":false,"message":"Scope not found","error":10,"data":null}}}}},"security":[{"Basic-Authentication":[]}]}},"/callbacks/{id}":{"get":{"summary":"Get callback by ID","tags":["Callbacks"],"parameters":[{"name":"id","in":"path","required":true,"schema":{"type":"string"},"description":"Callback ID"}],"responses":{"200":{"description":"Callback detail","content":{"application/json":{"schema":{"type":"object","properties":{"data":{"$ref":"#/components/schemas/Callback"}}},"example":{"data":{"id":"65a1b2c3d4e5f6789abcdef0","scope":"POST:company.openapi.com/webhook","domain":"company.openapi.com","active":false,"startedAt":"2026-02-12T10:00:00+00:00","createdAt":"2026-02-12T09:59:55+00:00","completedAt":"2026-02-12T10:00:05+00:00","httpResponseCode":200,"data":{"event":"user.created","userId":"12345"},"custom":{"trackingId":"abc-123"},"headers":{"Content-Type":"application/json","X-Webhook-Signature":"sha256=..."},"elapsedTime":5234,"attempt":1,"retry":0,"field":"webhookUrl","method":"POST","url":"https://example.com/callback"}}}}},"404":{"description":"Callback not found","content":{"application/json":{"example":{"success":false,"message":"Callback not found","error":200,"data":null}}}}},"security":[{"Basic-Authentication":[]}]}},"/wallet/transactions":{"get":{"summary":"Get wallet transactions history","tags":["Wallet"],"parameters":[{"name":"skip","in":"query","required":false,"schema":{"type":"integer","default":0},"description":"Number of transactions to skip for pagination"},{"name":"limit","in":"query","required":false,"schema":{"type":"integer","default":100,"maximum":100},"description":"Maximum number of transactions to return"}],"responses":{"200":{"description":"List of wallet transactions","content":{"application/json":{"schema":{"type":"object","properties":{"data":{"type":"array","items":{"$ref":"#/components/schemas/WalletTransaction"}}}},"example":{"data":[{"id":"txn_65a1b2c3d4e5f6789abc001","amount":-15.5,"createdAt":"2026-02-12T08:30:00+00:00","description":"API usage - company.openapi.com"},{"id":"txn_65a1b2c3d4e5f6789abc002","amount":100,"createdAt":"2026-02-10T14:15:00+00:00","description":"Wallet recharge"},{"id":"txn_65a1b2c3d4e5f6789abc003","amount":-5.25,"createdAt":"2026-02-09T11:20:00+00:00","description":"API usage - sms.openapi.com"}]}}}}},"security":[{"Basic-Authentication":[]}]}},"/subscriptions/{id}":{"get":{"summary":"Get subscription by ID","tags":["Subscriptions"],"parameters":[{"name":"id","in":"path","required":true,"schema":{"type":"string"},"description":"Subscription ID"}],"responses":{"200":{"description":"Subscription detail","content":{"application/json":{"schema":{"type":"object","properties":{"data":{"$ref":"#/components/schemas/Subscription"}}},"example":{"data":{"id":"656d1e2f8b3c2a001f7e4a20","scope":"GET:company.openapi.com/resource","domain":"company.openapi.com","active":true,"startsAt":"2025-11-01T00:00:00+00:00","expiresAt":"2025-12-01T00:00:00+00:00","totalRequests":"1000","availableRequests":"950","pricePerRequest":0.01,"type":"monthly","autorenew":true,"createdAt":"2025-10-25T10:00:00+00:00","updatedAt":"2025-11-19T15:30:00+00:00","price":10}}}}},"404":{"description":"Subscription not found","content":{"application/json":{"example":{"success":false,"message":"Subscription not found","error":220,"data":null}}}}},"security":[{"Basic-Authentication":[]}]}}},"components":{"securitySchemes":{"Basic-Authentication":{"description":"Basic authentication with EMAIL and APIKEY. Use the API key as the password and the email associated with the API key as the username in the Authorization header.","name":"Authorization","type":"http","scheme":"basic"},"Refresh-Authentication":{"description":"Bearer token authentication. Use a refresh token as the Bearer token in the Authorization header only for PATCH /tokens/{id} endpoint to update a token using its refresh token instead of the access token.","type":"http","scheme":"bearer"}},"schemas":{"TokenListOrDetail":{"type":"object","properties":{"data":{"oneOf":[{"type":"array","items":{"$ref":"#/components/schemas/TokenDetail"}},{"$ref":"#/components/schemas/TokenDetail"}]}}},"TokenDetail":{"type":"object","properties":{"token":{"type":"string","description":"Unique token identifier","example":"656d1e2f8b3c2a001f7e4a12"},"name":{"type":"string","description":"Human readable token name","example":"Service X API token"},"createdAt":{"type":"string","format":"date-time","description":"Creation timestamp","example":"2025-11-19T10:00:00Z"},"expireAt":{"type":"string","format":"date-time","description":"Expiration timestamp","example":"2025-12-19T10:00:00Z"},"updatedAt":{"type":"string","format":"date-time","description":"Last update timestamp","example":"2025-11-20T09:00:00Z"},"scopes":{"type":"array","items":{"type":"string"},"description":"Associated scopes","example":["GET:api.openapi.com/resource"]},"refreshToken":{"type":"string","description":"Associated refresh token. Is used to extend the token's TTL","example":"656d1e2f8b3c2a001f7e4a13"},"limits":{"$ref":"#/components/schemas/TokenLimits"},"stats":{"$ref":"#/components/schemas/TokenStats"}}},"TokenCreate":{"type":"object","description":"Data to create a new token","properties":{"scopes":{"type":"array","description":"List of requested scopes","items":{"type":"string","example":"GET:api.openapi.com/resource"},"example":["GET:api.openapi.com/resource","POST:other.openapi.com/other"]},"name":{"type":"string","description":"Human-readable token name","example":"Service X API token"},"ttl":{"type":"integer","description":"Token lifetime in seconds. Max 1 year. If a negative value or 0 is provided, the value is automatically clamped to the default TTL.","example":2592000},"limits":{"$ref":"#/components/schemas/TokenLimits"}},"required":["scopes"]},"TokenUpdate":{"type":"object","description":"Data to update an existing token. Authentication may use a Bearer access token or, alternatively, a refresh token passed as the Bearer token in the Authorization header. When using a refresh token, a new token and a new refresh token with the same scopes are returned, and the previous token is deleted.","properties":{"scopes":{"type":"array","description":"New list of scopes","items":{"type":"string","example":"GET:api.openapi.com/resource"},"example":["GET:api.openapi.com/resource","POST:other.openapi.com/other"]},"name":{"type":"string","description":"New token name","example":"Updated token"},"ttl":{"type":"integer","description":"New lifetime in seconds","example":604800},"limits":{"$ref":"#/components/schemas/TokenLimits"}}},"TokenLimits":{"type":"object","description":"Usage limits associated with the token","properties":{"totalRequests":{"type":"integer","description":"Maximum number of total allowed requests","example":10000},"walletRequests":{"type":"integer","description":"Maximum number of paid wallet requests allowed","example":1000},"subscriptionRequests":{"type":"integer","description":"Maximum number of subscription requests allowed","example":500},"walletAmount":{"type":"number","description":"Maximum amount usable from the associated wallet","example":50},"ip":{"type":"array","description":"List of allowed IP addresses","items":{"type":"string","example":"192.168.1.1"},"example":["192.168.1.1","10.0.0.2"]}}},"TokenStats":{"type":"object","description":"Usage statistics for the token","properties":{"totalRequests":{"type":"integer","description":"Total number of requests made","example":1234},"walletRequests":{"type":"integer","description":"Number of paid wallet requests made","example":120},"subscriptionRequests":{"type":"integer","description":"Number of subscription requests made","example":30},"errorRequests":{"type":"integer","description":"Number of requests that resulted in an error","example":5},"walletAmount":{"type":"number","description":"Total amount spent via wallet","example":12.5},"ip":{"type":"array","description":"List of IP addresses used","items":{"type":"string","example":"192.168.1.1"},"example":["192.168.1.1","10.0.0.2"]}}},"UserScope":{"type":"object","description":"Basic scope information available in list view","properties":{"id":{"type":"string","description":"Scope unique identifier","example":"656d1e2f8b3c2a001f7e4a14"},"scope":{"type":"string","description":"Scope name","example":"GET:api.openapi.com/resource"},"method":{"type":"string","description":"HTTP method","example":"GET"},"endpoint":{"type":"string","description":"Associated endpoint","example":"resource"},"domain":{"type":"string","description":"Associated domain","example":"api.openapi.com"},"enabled":{"type":"boolean","description":"Whether this scope is enabled for the authenticated user","example":true}}},"ScopeDetail":{"type":"object","description":"Detailed scope information including limits, requirements and pricing","allOf":[{"$ref":"#/components/schemas/UserScope"},{"type":"object","properties":{"rateLimit":{"oneOf":[{"type":"string"},{"type":"boolean"}],"description":"Rate limit for this scope, or false if no limit","example":false},"freeLimits":{"$ref":"#/components/schemas/ScopeLimits"},"requirements":{"type":"object","description":"Requirements for this scope with their fulfillment status","additionalProperties":{"type":"boolean"},"example":{"id_card":false,"oa_general_contract":false}},"prices":{"type":"object","description":"Pricing information for this scope by price key","additionalProperties":{"type":"number"},"example":{"ch-start":0.06}}}}]},"ScopeLimits":{"type":"object","description":"Free usage limits for a scope","properties":{"dayLimit":{"oneOf":[{"type":"integer"},{"type":"boolean"}],"description":"Daily request limit, or false if no limit","example":0},"monthLimit":{"oneOf":[{"type":"integer"},{"type":"boolean"}],"description":"Monthly request limit, or false if no limit","example":false},"yearLimit":{"oneOf":[{"type":"integer"},{"type":"boolean"}],"description":"Yearly request limit, or false if no limit","example":false},"totalLimit":{"oneOf":[{"type":"integer"},{"type":"boolean"}],"description":"Total request limit (lifetime), or false if no limit","example":false}}},"ErrorLog":{"type":"object","description":"Error log entry","properties":{"id":{"type":"string","description":"Error log unique identifier","example":"69822d1d48be79971b04351a"},"scope":{"type":"string","description":"Scope that caused the error","example":"DELETE:oauth.openapi.com/tokens"},"domain":{"type":"string","description":"API domain where the error occurred","example":"oauth.openapi.com"},"errorAt":{"type":"string","format":"date-time","description":"Timestamp when the error occurred","example":"2026-02-03T17:15:09+00:00"},"httpResponseCode":{"type":"integer","description":"HTTP response status code","example":404},"errorCode":{"type":"number","description":"Internal error code","example":131},"message":{"type":"string","description":"Error message","example":"Not Found"},"ip":{"type":"string","description":"IP address that triggered the error","example":"93.146.69.125"}}},"Wallet":{"type":"object","description":"Wallet information","properties":{"credit":{"type":"number","description":"Current wallet credit balance","example":125.5},"createdAt":{"type":"string","format":"date-time","description":"Wallet creation date","example":"2025-01-15T10:00:00+00:00"},"updatedAt":{"type":"string","format":"date-time","description":"Last wallet update date","example":"2026-02-12T08:30:00+00:00"}}},"WalletTransaction":{"type":"object","description":"Wallet transaction entry","properties":{"id":{"type":"string","description":"Transaction unique identifier","example":"txn_65a1b2c3d4e5f6789abc001"},"amount":{"type":"number","description":"Transaction amount (negative for expenses, positive for credits)","example":-15.5},"createdAt":{"type":"string","format":"date-time","description":"Transaction timestamp","example":"2026-02-12T08:30:00+00:00"},"description":{"type":"string","description":"Transaction description","example":"API usage - company.openapi.com"}}},"CallbackListElement":{"type":"object","description":"Simplified callback information for list view","properties":{"id":{"type":"string","description":"Callback unique identifier","example":"65a1b2c3d4e5f6789abcdef0"},"scope":{"type":"string","description":"Scope that triggered this callback","example":"POST:company.openapi.com/webhook"},"url":{"type":"string","description":"Callback destination URL","example":"https://example.com/callback"},"httpResponseCode":{"type":"string","description":"HTTP response code received from the callback URL","example":"200"},"startedAt":{"type":"string","format":"date-time","description":"Callback execution start time","example":"2026-02-12T10:00:00+00:00"},"completedAt":{"type":"string","format":"date-time","description":"Callback execution completion time (null if still active)","example":"2026-02-12T10:00:05+00:00","nullable":true}}},"Callback":{"type":"object","description":"Complete callback information","properties":{"id":{"type":"string","description":"Callback unique identifier","example":"65a1b2c3d4e5f6789abcdef0"},"scope":{"type":"string","description":"Scope that triggered this callback","example":"POST:company.openapi.com/webhook"},"domain":{"type":"string","description":"API domain for this callback","example":"company.openapi.com","nullable":true},"active":{"type":"boolean","description":"Whether the callback is still active (not completed)","example":false},"startedAt":{"type":"string","format":"date-time","description":"Callback execution start time","example":"2026-02-12T10:00:00+00:00"},"createdAt":{"type":"string","format":"date-time","description":"Callback creation time","example":"2026-02-12T09:59:55+00:00"},"completedAt":{"type":"string","format":"date-time","description":"Callback execution completion time","example":"2026-02-12T10:00:05+00:00","nullable":true},"httpResponseCode":{"type":"integer","description":"HTTP response code received from the callback URL","example":200},"data":{"type":"object","description":"Callback payload data","example":{"event":"user.created","userId":"12345"}},"custom":{"description":"Custom data associated with the callback","example":{"trackingId":"abc-123"}},"headers":{"type":"object","description":"HTTP headers sent with the callback","example":{"Content-Type":"application/json","X-Webhook-Signature":"sha256=..."}},"elapsedTime":{"type":"integer","description":"Callback execution time in milliseconds","example":5234},"attempt":{"type":"integer","description":"Current attempt number","example":1},"retry":{"type":"integer","description":"Number of retries performed","example":0},"field":{"type":"string","description":"Field identifier for the callback","example":"webhookUrl"},"method":{"type":"string","description":"HTTP method used for the callback","example":"POST"},"url":{"type":"string","description":"Callback destination URL","example":"https://example.com/callback"}}},"SubscriptionListElement":{"type":"object","description":"Simplified subscription information for list view","properties":{"id":{"type":"string","description":"Subscription unique identifier","example":"656d1e2f8b3c2a001f7e4a20"},"scope":{"type":"string","description":"Scope this subscription applies to","example":"GET:company.openapi.com/resource"},"active":{"type":"boolean","description":"Whether the subscription is currently active","example":true},"availableRequests":{"type":"string","description":"Number of requests available in this subscription","example":"950"},"startsAt":{"type":"string","format":"date-time","description":"Subscription start date","example":"2025-11-01T00:00:00+00:00"},"expiresAt":{"type":"string","format":"date-time","description":"Subscription expiration date","example":"2025-12-01T00:00:00+00:00"}}},"Subscription":{"type":"object","description":"Complete subscription information","properties":{"id":{"type":"string","description":"Subscription unique identifier","example":"656d1e2f8b3c2a001f7e4a20"},"scope":{"type":"string","description":"Scope this subscription applies to","example":"GET:company.openapi.com/resource"},"domain":{"type":"string","description":"API domain for this subscription","example":"company.openapi.com"},"active":{"type":"boolean","description":"Whether the subscription is currently active","example":true},"startsAt":{"type":"string","format":"date-time","description":"Subscription start date","example":"2025-11-01T00:00:00+00:00"},"expiresAt":{"type":"string","format":"date-time","description":"Subscription expiration date","example":"2025-12-01T00:00:00+00:00"},"totalRequests":{"type":"string","description":"Total number of requests originally included in this subscription","example":"1000"},"availableRequests":{"type":"string","description":"Number of requests still available in this subscription","example":"950"},"pricePerRequest":{"type":"number","description":"Price per request for this subscription","example":0.01},"type":{"type":"string","description":"Subscription type (e.g., month, year)","example":"month"},"autorenew":{"type":"boolean","description":"Whether the subscription will automatically renew","example":true},"createdAt":{"type":"string","format":"date-time","description":"Subscription creation date","example":"2025-10-25T10:00:00+00:00"},"updatedAt":{"type":"string","format":"date-time","description":"Last update date","example":"2025-11-19T15:30:00+00:00"},"price":{"type":"number","description":"Total price of the subscription","example":10}}}}},"externalDocs":{"description":"First time here? Generate a new access token","url":"https://console.openapi.com/oauth"}}