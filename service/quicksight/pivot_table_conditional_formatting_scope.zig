const PivotTableConditionalFormattingScopeRole = @import("pivot_table_conditional_formatting_scope_role.zig").PivotTableConditionalFormattingScopeRole;

/// The scope of the cell for conditional formatting.
pub const PivotTableConditionalFormattingScope = struct {
    /// The role (field, field total, grand total) of the cell for conditional
    /// formatting.
    role: ?PivotTableConditionalFormattingScopeRole = null,

    pub const json_field_names = .{
        .role = "Role",
    };
};
