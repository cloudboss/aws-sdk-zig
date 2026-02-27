const ListProgramManagementAccountsSortName = @import("list_program_management_accounts_sort_name.zig").ListProgramManagementAccountsSortName;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Base sorting configuration for program management accounts.
pub const ListProgramManagementAccountsSortBase = struct {
    /// The field to sort by.
    sort_by: ListProgramManagementAccountsSortName,

    /// The sort order (ascending or descending).
    sort_order: SortOrder,

    pub const json_field_names = .{
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};
