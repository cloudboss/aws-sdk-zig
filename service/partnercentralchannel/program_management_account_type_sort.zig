const ProgramManagementAccountTypeSortName = @import("program_management_account_type_sort_name.zig").ProgramManagementAccountTypeSortName;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Type-specific sorting options for program management accounts.
pub const ProgramManagementAccountTypeSort = struct {
    /// The field to sort by.
    sort_by: ProgramManagementAccountTypeSortName,

    /// The sort order (ascending or descending).
    sort_order: SortOrder,

    pub const json_field_names = .{
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};
