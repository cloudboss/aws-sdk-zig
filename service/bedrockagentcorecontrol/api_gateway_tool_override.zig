const RestApiMethod = @import("rest_api_method.zig").RestApiMethod;

/// Settings to override configurations for a tool.
pub const ApiGatewayToolOverride = struct {
    /// The description of the tool. Provides information about the purpose and
    /// usage of the tool. If not provided, uses the description from the API's
    /// OpenAPI specification.
    description: ?[]const u8 = null,

    /// The HTTP method to expose for the specified path.
    method: RestApiMethod,

    /// The name of tool. Identifies the tool in the Model Context Protocol.
    name: []const u8,

    /// Resource path in the REST API (e.g., `/pets`). Must explicitly match an
    /// existing path in the REST API.
    path: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .method = "method",
        .name = "name",
        .path = "path",
    };
};
