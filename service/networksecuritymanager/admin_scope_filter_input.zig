const AdminScopeSelectionInput = @import("admin_scope_selection_input.zig").AdminScopeSelectionInput;

/// Determines which accounts and organizational units are in an administrator's
/// scope. This is the input form, which uses account and organizational unit
/// IDs.
pub const AdminScopeFilterInput = union(enum) {
    /// The accounts and organizational units to exclude from the administrator's
    /// scope. All others are in scope.
    exclude_only: ?AdminScopeSelectionInput,
    /// All accounts and organizational units are in scope.
    include_all: ?struct {},
    /// Only the specified accounts and organizational units are in the
    /// administrator's scope.
    include_only: ?AdminScopeSelectionInput,

    pub const json_field_names = .{
        .exclude_only = "excludeOnly",
        .include_all = "includeAll",
        .include_only = "includeOnly",
    };
};
