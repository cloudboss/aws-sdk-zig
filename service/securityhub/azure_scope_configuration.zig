const ScopeType = @import("scope_type.zig").ScopeType;

/// The scope configuration for an Azure connector, defining the tenant or
/// subscription scope.
pub const AzureScopeConfiguration = struct {
    /// The type of scope. Valid values are `tenant` and `subscription`.
    scope_type: ScopeType,

    /// The list of scope values, such as subscription IDs, when the scope type is
    /// `subscription`.
    scope_values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .scope_type = "ScopeType",
        .scope_values = "ScopeValues",
    };
};
