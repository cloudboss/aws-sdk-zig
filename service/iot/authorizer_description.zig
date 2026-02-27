const aws = @import("aws");

const AuthorizerStatus = @import("authorizer_status.zig").AuthorizerStatus;

/// The authorizer description.
pub const AuthorizerDescription = struct {
    /// The authorizer ARN.
    authorizer_arn: ?[]const u8,

    /// The authorizer's Lambda function ARN.
    authorizer_function_arn: ?[]const u8,

    /// The authorizer name.
    authorizer_name: ?[]const u8,

    /// The UNIX timestamp of when the authorizer was created.
    creation_date: ?i64,

    /// When `true`, the result from the authorizer’s Lambda function is
    /// cached for the time specified in `refreshAfterInSeconds`. The cached
    /// result is used while the device reuses the same HTTP connection.
    enable_caching_for_http: ?bool,

    /// The UNIX timestamp of when the authorizer was last updated.
    last_modified_date: ?i64,

    /// Specifies whether IoT validates the token signature in an authorization
    /// request.
    signing_disabled: ?bool,

    /// The status of the authorizer.
    status: ?AuthorizerStatus,

    /// The key used to extract the token from the HTTP headers.
    token_key_name: ?[]const u8,

    /// The public keys used to validate the token signature returned by your custom
    /// authentication service.
    token_signing_public_keys: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .authorizer_arn = "authorizerArn",
        .authorizer_function_arn = "authorizerFunctionArn",
        .authorizer_name = "authorizerName",
        .creation_date = "creationDate",
        .enable_caching_for_http = "enableCachingForHttp",
        .last_modified_date = "lastModifiedDate",
        .signing_disabled = "signingDisabled",
        .status = "status",
        .token_key_name = "tokenKeyName",
        .token_signing_public_keys = "tokenSigningPublicKeys",
    };
};
