const AccountSet = @import("account_set.zig").AccountSet;

/// Determines which accounts are in scope. Exactly one of `includeAll`,
/// `include`, or `exclude` is set.
pub const AccountFilter = union(enum) {
    /// Excludes the specified accounts and organizational units. All others are in
    /// scope.
    exclude: ?AccountSet,
    /// Includes only the specified accounts and organizational units.
    include: ?AccountSet,
    /// Includes all accounts. No account filtering is applied.
    include_all: ?struct {},

    pub const json_field_names = .{
        .exclude = "exclude",
        .include = "include",
        .include_all = "includeAll",
    };
};
