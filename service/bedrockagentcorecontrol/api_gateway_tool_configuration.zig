const ApiGatewayToolFilter = @import("api_gateway_tool_filter.zig").ApiGatewayToolFilter;
const ApiGatewayToolOverride = @import("api_gateway_tool_override.zig").ApiGatewayToolOverride;

/// The configuration for defining REST API tool filters and overrides for the
/// gateway target.
pub const ApiGatewayToolConfiguration = struct {
    /// A list of path and method patterns to expose as tools using metadata from
    /// the REST API's OpenAPI specification.
    tool_filters: []const ApiGatewayToolFilter,

    /// A list of explicit tool definitions with optional custom names and
    /// descriptions.
    tool_overrides: ?[]const ApiGatewayToolOverride,

    pub const json_field_names = .{
        .tool_filters = "toolFilters",
        .tool_overrides = "toolOverrides",
    };
};
