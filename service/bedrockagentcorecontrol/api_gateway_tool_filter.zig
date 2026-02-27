const RestApiMethod = @import("rest_api_method.zig").RestApiMethod;

/// Specifies which operations from an API Gateway REST API are exposed as
/// tools. Tool names and descriptions are derived from the operationId and
/// description fields in the API's exported OpenAPI specification.
pub const ApiGatewayToolFilter = struct {
    /// Resource path to match in the REST API. Supports exact paths (for example,
    /// `/pets`) or wildcard paths (for example, `/pets/*` to match all paths under
    /// `/pets`). Must match existing paths in the REST API.
    filter_path: []const u8,

    /// The methods to filter for.
    methods: []const RestApiMethod,

    pub const json_field_names = .{
        .filter_path = "filterPath",
        .methods = "methods",
    };
};
