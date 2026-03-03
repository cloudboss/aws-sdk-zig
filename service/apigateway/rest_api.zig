const aws = @import("aws");

const ApiKeySourceType = @import("api_key_source_type.zig").ApiKeySourceType;
const ApiStatus = @import("api_status.zig").ApiStatus;
const EndpointAccessMode = @import("endpoint_access_mode.zig").EndpointAccessMode;
const EndpointConfiguration = @import("endpoint_configuration.zig").EndpointConfiguration;
const SecurityPolicy = @import("security_policy.zig").SecurityPolicy;

/// Represents a REST API.
pub const RestApi = struct {
    /// The source of the API key for metering requests according to a usage plan.
    /// Valid values
    /// are: >`HEADER` to read the API key from the `X-API-Key` header of a
    /// request. `AUTHORIZER` to read the API key from the `UsageIdentifierKey`
    /// from a custom authorizer.
    api_key_source: ?ApiKeySourceType = null,

    /// The ApiStatus of the RestApi.
    api_status: ?ApiStatus = null,

    /// The status message of the RestApi. When the status message is `UPDATING` you
    /// can still invoke it.
    api_status_message: ?[]const u8 = null,

    /// The list of binary media types supported by the RestApi. By default, the
    /// RestApi supports only UTF-8-encoded text payloads.
    binary_media_types: ?[]const []const u8 = null,

    /// The timestamp when the API was created.
    created_date: ?i64 = null,

    /// The API's description.
    description: ?[]const u8 = null,

    /// Specifies whether clients can invoke your API by using the default
    /// `execute-api` endpoint.
    /// By default, clients can invoke your API with the default
    /// `https://{api_id}.execute-api.{region}.amazonaws.com` endpoint. To require
    /// that clients use a
    /// custom domain name to invoke your API, disable the default endpoint.
    disable_execute_api_endpoint: bool = false,

    /// The endpoint access mode of the RestApi.
    endpoint_access_mode: ?EndpointAccessMode = null,

    /// The endpoint configuration of this RestApi showing the endpoint types and IP
    /// address types of the API.
    endpoint_configuration: ?EndpointConfiguration = null,

    /// The API's identifier. This identifier is unique across all of your APIs in
    /// API Gateway.
    id: ?[]const u8 = null,

    /// A nullable integer that is used to enable compression (with non-negative
    /// between 0 and 10485760 (10M) bytes, inclusive) or disable compression (with
    /// a null value) on an API. When compression is enabled, compression or
    /// decompression is not applied on the payload if the payload size is smaller
    /// than this value. Setting it to zero allows compression for any payload size.
    minimum_compression_size: ?i32 = null,

    /// The API's name.
    name: ?[]const u8 = null,

    /// A stringified JSON policy document that applies to this RestApi regardless
    /// of the caller and Method configuration.
    policy: ?[]const u8 = null,

    /// The API's root resource ID.
    root_resource_id: ?[]const u8 = null,

    /// The Transport Layer Security (TLS) version + cipher suite for this RestApi.
    security_policy: ?SecurityPolicy = null,

    /// The collection of tags. Each tag element is associated with a given
    /// resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// A version identifier for the API.
    version: ?[]const u8 = null,

    /// The warning messages reported when `failonwarnings` is turned on during API
    /// import.
    warnings: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .api_key_source = "apiKeySource",
        .api_status = "apiStatus",
        .api_status_message = "apiStatusMessage",
        .binary_media_types = "binaryMediaTypes",
        .created_date = "createdDate",
        .description = "description",
        .disable_execute_api_endpoint = "disableExecuteApiEndpoint",
        .endpoint_access_mode = "endpointAccessMode",
        .endpoint_configuration = "endpointConfiguration",
        .id = "id",
        .minimum_compression_size = "minimumCompressionSize",
        .name = "name",
        .policy = "policy",
        .root_resource_id = "rootResourceId",
        .security_policy = "securityPolicy",
        .tags = "tags",
        .version = "version",
        .warnings = "warnings",
    };
};
