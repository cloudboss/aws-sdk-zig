/// The identifier parts of a product REST endpoint.
pub const IdentifierParts = struct {
    /// The method of the product REST endpoint.
    method: []const u8,

    /// The path of the product REST endpoint.
    path: []const u8,

    /// The REST API ID of the product REST endpoint.
    rest_api_id: []const u8,

    /// The stage of the product REST endpoint.
    stage: []const u8,

    pub const json_field_names = .{
        .method = "Method",
        .path = "Path",
        .rest_api_id = "RestApiId",
        .stage = "Stage",
    };
};
