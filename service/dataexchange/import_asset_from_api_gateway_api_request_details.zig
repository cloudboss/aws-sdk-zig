const ProtocolType = @import("protocol_type.zig").ProtocolType;

/// The request details.
pub const ImportAssetFromApiGatewayApiRequestDetails = struct {
    /// The API description. Markdown supported.
    api_description: ?[]const u8 = null,

    /// The API Gateway API ID.
    api_id: []const u8,

    /// The API Gateway API key.
    api_key: ?[]const u8 = null,

    /// The API name.
    api_name: []const u8,

    /// The Base64-encoded MD5 hash of the OpenAPI 3.0 JSON API specification file.
    /// It is used
    /// to ensure the integrity of the file.
    api_specification_md_5_hash: []const u8,

    /// The data set ID.
    data_set_id: []const u8,

    /// The protocol type.
    protocol_type: ProtocolType,

    /// The revision ID.
    revision_id: []const u8,

    /// The API stage.
    stage: []const u8,

    pub const json_field_names = .{
        .api_description = "ApiDescription",
        .api_id = "ApiId",
        .api_key = "ApiKey",
        .api_name = "ApiName",
        .api_specification_md_5_hash = "ApiSpecificationMd5Hash",
        .data_set_id = "DataSetId",
        .protocol_type = "ProtocolType",
        .revision_id = "RevisionId",
        .stage = "Stage",
    };
};
