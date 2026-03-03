/// Contains any values that override the default configuration generated from
/// API Gateway.
pub const DisplayContentOverrides = struct {
    /// By default, this is the documentation of your REST API from API Gateway. You
    /// can provide custom documentation to override this value.
    body: ?[]const u8 = null,

    /// The URL for your REST API. By default, API Gateway uses the default execute
    /// API endpoint. You can provide a custom domain to override this value.
    endpoint: ?[]const u8 = null,

    /// The operation name of the product REST endpoint.
    operation_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .body = "Body",
        .endpoint = "Endpoint",
        .operation_name = "OperationName",
    };
};
