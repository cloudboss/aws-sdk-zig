const DataConnector = @import("data_connector.zig").DataConnector;
const Scope = @import("scope.zig").Scope;

/// The function request body.
pub const FunctionRequest = struct {
    /// The data connector.
    implemented_by: ?DataConnector = null,

    /// The required properties of the function.
    required_properties: ?[]const []const u8 = null,

    /// The scope of the function.
    scope: ?Scope = null,

    pub const json_field_names = .{
        .implemented_by = "implementedBy",
        .required_properties = "requiredProperties",
        .scope = "scope",
    };
};
