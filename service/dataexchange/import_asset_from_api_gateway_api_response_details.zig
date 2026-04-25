const ProtocolType = @import("protocol_type.zig").ProtocolType;

/// The response details.
pub const ImportAssetFromApiGatewayApiResponseDetails = struct {
    /// The API description.
    api_description: ?[]const u8 = null,

    /// The API ID.
    api_id: []const u8,

    /// The API key.
    api_key: ?[]const u8 = null,

    /// The API name.
    api_name: []const u8,

    /// The Base64-encoded Md5 hash for the API asset, used to ensure the integrity
    /// of the API at that location.
    api_specification_md_5_hash: []const u8,

    /// The upload URL of the API specification.
    api_specification_upload_url: []const u8,

    /// The date and time that the upload URL expires, in ISO 8601 format.
    api_specification_upload_url_expires_at: i64,

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
        .api_specification_upload_url = "ApiSpecificationUploadUrl",
        .api_specification_upload_url_expires_at = "ApiSpecificationUploadUrlExpiresAt",
        .data_set_id = "DataSetId",
        .protocol_type = "ProtocolType",
        .revision_id = "RevisionId",
        .stage = "Stage",
    };
};
