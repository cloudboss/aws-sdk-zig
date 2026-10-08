const aws = @import("aws");

const AccountFilter = @import("account_filter.zig").AccountFilter;
const ResourceScope = @import("resource_scope.zig").ResourceScope;

/// Defines which accounts and resources are in scope.
pub const ScopeConfiguration = struct {
    /// The account filter that determines which accounts are in scope. When set,
    /// exactly one of `includeAll`, `include`, or `exclude` is set.
    ///
    /// Organization administrators must include an account filter in every scope
    /// configuration. Single-account administrators must omit it: a scope without
    /// an account filter applies only to the administrator's own account. The
    /// presence of an account filter is fixed when the scope is created: an update
    /// can't add an account filter to a scope that was created without one, or
    /// remove the account filter from a scope that was created with one.
    account_filter: ?AccountFilter = null,

    /// The resource-level scoping configuration, keyed by resource type, that
    /// defines which resources within the selected accounts are in scope.
    resource_scopes: []const aws.map.MapEntry(ResourceScope),

    pub const json_field_names = .{
        .account_filter = "accountFilter",
        .resource_scopes = "resourceScopes",
    };
};
