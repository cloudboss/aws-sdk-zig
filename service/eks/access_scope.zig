const AccessScopeType = @import("access_scope_type.zig").AccessScopeType;

/// The scope of an `AccessPolicy` that's associated to an
/// `AccessEntry`.
pub const AccessScope = struct {
    /// A Kubernetes `namespace` that an access policy is scoped to. A value is
    /// required
    /// if you specified `namespace` for `Type`.
    namespaces: ?[]const []const u8,

    /// The scope type of an access policy.
    @"type": ?AccessScopeType,

    pub const json_field_names = .{
        .namespaces = "namespaces",
        .@"type" = "type",
    };
};
