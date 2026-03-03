/// Represents an API mapping.
pub const ApiMapping = struct {
    /// The API identifier.
    api_id: []const u8,

    /// The API mapping identifier.
    api_mapping_id: ?[]const u8 = null,

    /// The API mapping key.
    api_mapping_key: ?[]const u8 = null,

    /// The API stage.
    stage: []const u8,

    pub const json_field_names = .{
        .api_id = "ApiId",
        .api_mapping_id = "ApiMappingId",
        .api_mapping_key = "ApiMappingKey",
        .stage = "Stage",
    };
};
