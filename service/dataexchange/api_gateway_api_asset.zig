const ProtocolType = @import("protocol_type.zig").ProtocolType;

/// The API Gateway API that is the asset.
pub const ApiGatewayApiAsset = struct {
    /// The API description of the API asset.
    api_description: ?[]const u8,

    /// The API endpoint of the API asset.
    api_endpoint: ?[]const u8,

    /// The unique identifier of the API asset.
    api_id: ?[]const u8,

    /// The API key of the API asset.
    api_key: ?[]const u8,

    /// The API name of the API asset.
    api_name: ?[]const u8,

    /// The download URL of the API specification of the API asset.
    api_specification_download_url: ?[]const u8,

    /// The date and time that the upload URL expires, in ISO 8601 format.
    api_specification_download_url_expires_at: ?i64,

    /// The protocol type of the API asset.
    protocol_type: ?ProtocolType,

    /// The stage of the API asset.
    stage: ?[]const u8,

    pub const json_field_names = .{
        .api_description = "ApiDescription",
        .api_endpoint = "ApiEndpoint",
        .api_id = "ApiId",
        .api_key = "ApiKey",
        .api_name = "ApiName",
        .api_specification_download_url = "ApiSpecificationDownloadUrl",
        .api_specification_download_url_expires_at = "ApiSpecificationDownloadUrlExpiresAt",
        .protocol_type = "ProtocolType",
        .stage = "Stage",
    };
};
