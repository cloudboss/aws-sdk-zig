const KafkaClusterOAuthClientCredentials = @import("kafka_cluster_o_auth_client_credentials.zig").KafkaClusterOAuthClientCredentials;
const KafkaClusterOAuthClientCredentialsAssertion = @import("kafka_cluster_o_auth_client_credentials_assertion.zig").KafkaClusterOAuthClientCredentialsAssertion;
const KafkaClusterOAuthIamJwtBearer = @import("kafka_cluster_o_auth_iam_jwt_bearer.zig").KafkaClusterOAuthIamJwtBearer;
const TokenEndpointAuthenticationMethod = @import("token_endpoint_authentication_method.zig").TokenEndpointAuthenticationMethod;

/// Details for SASL/OAUTHBEARER client authentication.
pub const KafkaClusterSaslOAuthBearerAuthentication = struct {
    /// Details for SASL/OAUTHBEARER using standard client_credentials grant.
    client_credentials: ?KafkaClusterOAuthClientCredentials = null,

    /// Details for SASL/OAUTHBEARER using client credentials grant with JWT client
    /// assertion.
    client_credentials_assertion: ?KafkaClusterOAuthClientCredentialsAssertion = null,

    /// Details for SASL/OAUTHBEARER using JWT Bearer assertion grant (RFC 7523).
    iam_jwt_bearer: ?KafkaClusterOAuthIamJwtBearer = null,

    /// OAuth scope to request.
    scope: ?[]const u8 = null,

    /// How client credentials are sent to the identity provider. Valid values are
    /// POST, BASIC, or NONE.
    token_endpoint_authentication_method: TokenEndpointAuthenticationMethod,

    /// Secrets Manager ARN containing a custom CA certificate for the identity
    /// provider.
    token_endpoint_tls_certificate_arn: ?[]const u8 = null,

    /// The HTTPS URL of the OAuth token endpoint that vends OAuth Bearer tokens per
    /// RFC 6749.
    token_endpoint_url: []const u8,

    pub const json_field_names = .{
        .client_credentials = "ClientCredentials",
        .client_credentials_assertion = "ClientCredentialsAssertion",
        .iam_jwt_bearer = "IamJwtBearer",
        .scope = "Scope",
        .token_endpoint_authentication_method = "TokenEndpointAuthenticationMethod",
        .token_endpoint_tls_certificate_arn = "TokenEndpointTlsCertificateArn",
        .token_endpoint_url = "TokenEndpointUrl",
    };
};
