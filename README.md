# Alpha Rotato

A pipeline that hackily rotates your CF deployment credentials.

### Credential List

List based on cf-deployment at commit [98c1a7](https://github.com/cloudfoundry/cf-deployment/tree/98c1a7ecd8443832b14175d56083dfd4386cbcb9)

| Name                                                  | Rotation Method    | Downtime?   |
|-------------------------------------------------------|--------------------|-----------  |
| adapter_rlp_tls                                       | [Single Deploy][1] | Probably No  |
| adapter_tls                                           | [Single Deploy][1] | Probably No  |
| blobstore_admin_users_password                        | [Single Deploy][1] | Probably Yes |
| blobstore_secure_link_secret                          | [Single Deploy][1] | Probably Yes |
| blobstore_tls                                         | [Single Deploy][1] | Probably No  |
| cc_bridge_cc_uploader                                 | [Single Deploy][1] | Probably No  |
| cc_bridge_cc_uploader_server                          | [Single Deploy][1] | Probably No  |
| cc_bridge_tps                                         | [Single Deploy][1] | Probably No  |
| cc_bulk_api_password                                  | [Single Deploy][1] | Probably Yes |
| cc_database                                           | [New User][2]      | Probably No  |
| cc_db_encryption_key                                  | [None][99]         | N/A          |
| cc_internal_api_password                              | [Single Deploy][1] | Probably Yes |
| cc_staging_upload_password                            | [Single Deploy][1] | Probably Yes |
| cc_tls                                                | [Single Deploy][1] | Probably No  |
| cf_admin_password                                     | [Single Deploy][1] | Probably Yes |
| cf_mysql_mysql_admin_password                         | [Single Deploy][1] | Probably Yes |
| cf_mysql_mysql_cluster_health_password                | ?                  |     ?        |
| cf_mysql_mysql_galera_healthcheck_endpoint_password   | ?                  |     ?        |
| cf_mysql_mysql_galera_healthcheck_password            | ?                  |     ?        |
| cf_mysql_proxy_api_password                           | ?                  |     ?        |
| consul_agent                                          | [Single Deploy][1] | Probably No  |
| consul_agent_ca                                       | [Three Stage][4]   | Probably No  |
| consul_encrypt_key                                    | [Three Stage][4]   | Probably No  |
| consul_server                                         | [Single Deploy][1] | Probably No  |
| diego_auctioneer_client                               | [Single Deploy][1] | Probably No  |
| diego_auctioneer_server                               | [Single Deploy][1] | Probably No  |
| diego_bbs_client                                      | [Single Deploy][1] | Probably No  |
| diego_bbs_encryption_keys_passphrase                  | [Three Stage][4]   | Probably No  |
| diego_bbs_server                                      | [Single Deploy][1] | Probably No  |
| diego_database                                        | [New User][2]      | Probably No  |
| diego_locket_client                                   | [Single Deploy][1] | Probably No  |
| diego_locket_server                                   | [Single Deploy][1] | Probably No  |
| diego_rep_agent                                       | [Single Deploy][1] | Probably No  |
| diego_rep_client                                      | [Single Deploy][1] | Probably No  |
| diego_ssh_proxy_host_key                              | [Single Deploy][1] | Probably No  |
| dropsonde_shared_secret                               | [Single Deploy][1] | Probably Yes |
| locket_database                                       | [New User][2]      | Probably No  |
| loggregator_ca                                        | [Three Stage][4]   | Probably No  |
| loggregator_tls_cc_tc                                 | [Single Deploy][1] | Probably No  |
| loggregator_tls_doppler                               | [Single Deploy][1] | Probably No  |
| loggregator_tls_metron                                | [Single Deploy][1] | Probably No  |
| loggregator_tls_rlp                                   | [Single Deploy][1] | Probably No  |
| loggregator_tls_statsdinjector                        | [Single Deploy][1] | Probably No  |
| loggregator_tls_tc                                    | [Single Deploy][1] | Probably No  |
| nats_password                                         | [Single Deploy][1] | Probably Yes |
| network_connectivity_database                         | [New User][2]      | Probably No  |
| network_policy_ca                                     | [Three Stage][4]   | Probably No  |
| network_policy_client                                 | [Single Deploy][1] | Probably No  |
| network_policy_database                               | [New User][2]      | Probably No  |
| network_policy_server                                 | [Single Deploy][1] | Probably No  |
| router_ca                                             | [Three Stage][4]   | Probably No  |
| router_route_services_secret                          | [Single Deploy][1] | Probably Yes |
| router_ssl                                            | [Single Deploy][1] | Probably No  |
| router_status_password                                | [Single Deploy][1] | Probably Yes |
| routing_api_database                                  | [New User][2]      | Probably No  |
| scheduler_api_tls                                     | [Single Deploy][1] | Probably No  |
| scheduler_client_tls                                  | [Single Deploy][1] | Probably No  |
| service_cf_internal_ca                                | [Three Stage][4]   | Probably No  |
| silk_ca                                               | [Three Stage][4]   | Probably No  |
| silk_controller                                       | [Single Deploy][1] | Probably No  |
| silk_daemon                                           | [Single Deploy][1] | Probably No  |
| uaa_admin_client_secret                               | [Single Deploy][1] | Probably Yes |
| uaa_ca                                                | [Three Stage][4]   | Probably No  |
| uaa_clients_cc-routing_secret                         | [Single Deploy][1] | Probably Yes |
| uaa_clients_cc-service-dashboards_secret              | [Single Deploy][1] | Probably Yes |
| uaa_clients_cc_service_key_client_secret              | [Single Deploy][1] | Probably Yes |
| uaa_clients_cloud_controller_username_lookup_secret   | [Single Deploy][1] | Probably Yes |
| uaa_clients_doppler_secret                            | [Single Deploy][1] | Probably Yes |
| uaa_clients_gorouter_secret                           | [Single Deploy][1] | Probably Yes |
| uaa_clients_network_policy_secret                     | [Single Deploy][1] | Probably Yes |
| uaa_clients_routing_api_client_secret                 | [Single Deploy][1] | Probably Yes |
| uaa_clients_ssh-proxy_secret                          | [Single Deploy][1] | Probably Yes |
| uaa_clients_tcp_emitter_secret                        | [Single Deploy][1] | Probably Yes |
| uaa_clients_tcp_router_secret                         | [Single Deploy][1] | Probably Yes |
| uaa_database                                          | [New User][2]      | Probably No  |
| uaa_jwt_signing_key                                   | [Two Stage][3]     | Probably No  |
| uaa_login_saml                                        | [Single Deploy][1] | Probably No  |
| uaa_ssl                                               | [Single Deploy][1] | Probably No  |

[1]:#single-deploy
[2]:#new-user
[3]:#two-stage
[4]:#three-stage
[99]:#none

### Rotation Methods

#### Single Deploy

Just change the value and deploy it again. The source and its consumers will be updated. This will cause downtime for things like passwords, because there will be a time when the source will not match the consumers.

#### New User

This method creates a new user with the appropriate access, then a second phase deletes the prior user. This allows rotation of password credentials without downtime.

#### Two Stage

#### Three Stage

#### None

This credential cannot be rotated. Period. :(
