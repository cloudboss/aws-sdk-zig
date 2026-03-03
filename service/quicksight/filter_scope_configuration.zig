const AllSheetsFilterScopeConfiguration = @import("all_sheets_filter_scope_configuration.zig").AllSheetsFilterScopeConfiguration;
const SelectedSheetsFilterScopeConfiguration = @import("selected_sheets_filter_scope_configuration.zig").SelectedSheetsFilterScopeConfiguration;

/// The scope configuration for a `FilterGroup`.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const FilterScopeConfiguration = struct {
    /// The configuration that applies a filter to all sheets. When you choose
    /// `AllSheets` as the value for a `FilterScopeConfiguration`, this filter is
    /// applied to all visuals of all sheets in an Analysis, Dashboard, or Template.
    /// The `AllSheetsFilterScopeConfiguration` is chosen.
    all_sheets: ?AllSheetsFilterScopeConfiguration = null,

    /// The configuration for applying a filter to specific sheets.
    selected_sheets: ?SelectedSheetsFilterScopeConfiguration = null,

    pub const json_field_names = .{
        .all_sheets = "AllSheets",
        .selected_sheets = "SelectedSheets",
    };
};
