const AdminScopeSelection = @import("admin_scope_selection.zig").AdminScopeSelection;

/// Determines which accounts and organizational units are in an administrator's
/// scope. This is the reference form, which includes display metadata.
pub const AdminScopeFilter = union(enum) {
    /// The accounts and organizational units to exclude from the administrator's
    /// scope. All others are in scope.
    exclude_only: ?AdminScopeSelection,
    /// All accounts and organizational units are in scope.
    include_all: ?struct {},
    /// Only the specified accounts and organizational units are in the
    /// administrator's scope.
    include_only: ?AdminScopeSelection,

    pub const json_field_names = .{
        .exclude_only = "excludeOnly",
        .include_all = "includeAll",
        .include_only = "includeOnly",
    };
};
