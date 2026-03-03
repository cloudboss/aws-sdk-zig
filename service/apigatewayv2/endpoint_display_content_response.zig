/// The product REST endpoint page.
pub const EndpointDisplayContentResponse = struct {
    /// The API documentation.
    body: ?[]const u8 = null,

    /// The URL to invoke your REST API.
    endpoint: []const u8,

    /// The operation name.
    operation_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .body = "Body",
        .endpoint = "Endpoint",
        .operation_name = "OperationName",
    };
};
