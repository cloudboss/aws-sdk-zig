const ScopeType = @import("scope_type.zig").ScopeType;

/// This data type contains key-value pairs that identify various Amazon
/// resources.
pub const Scope = struct {
    /// The type of the scope.
    key: ?ScopeType,

    /// The resource identifier for the specified scope type.
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
