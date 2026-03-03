const AwsApiGatewayEndpointConfiguration = @import("aws_api_gateway_endpoint_configuration.zig").AwsApiGatewayEndpointConfiguration;

/// Contains information about a REST API in version 1 of Amazon API Gateway.
pub const AwsApiGatewayRestApiDetails = struct {
    /// The source of the API key for metering requests according to a usage plan.
    ///
    /// `HEADER` indicates whether to read the API key from the X-API-Key header of
    /// a
    /// request.
    ///
    /// `AUTHORIZER` indicates whether to read the API key from the
    /// `UsageIdentifierKey` from a custom authorizer.
    api_key_source: ?[]const u8 = null,

    /// The list of binary media types supported by the REST API.
    binary_media_types: ?[]const []const u8 = null,

    /// Indicates when the API was created.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    created_date: ?[]const u8 = null,

    /// A description of the REST API.
    description: ?[]const u8 = null,

    /// The endpoint configuration of the REST API.
    endpoint_configuration: ?AwsApiGatewayEndpointConfiguration = null,

    /// The identifier of the REST API.
    id: ?[]const u8 = null,

    /// The minimum size in bytes of a payload before compression is enabled.
    ///
    /// If `null`, then compression is disabled.
    ///
    /// If 0, then all payloads are compressed.
    minimum_compression_size: ?i32 = null,

    /// The name of the REST API.
    name: ?[]const u8 = null,

    /// The version identifier for the REST API.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_key_source = "ApiKeySource",
        .binary_media_types = "BinaryMediaTypes",
        .created_date = "CreatedDate",
        .description = "Description",
        .endpoint_configuration = "EndpointConfiguration",
        .id = "Id",
        .minimum_compression_size = "MinimumCompressionSize",
        .name = "Name",
        .version = "Version",
    };
};
