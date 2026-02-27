const TablePinnedFieldOptions = @import("table_pinned_field_options.zig").TablePinnedFieldOptions;
const TableFieldOption = @import("table_field_option.zig").TableFieldOption;
const TransposedTableOption = @import("transposed_table_option.zig").TransposedTableOption;

/// The field options of a table visual.
pub const TableFieldOptions = struct {
    /// The order of the field IDs that are configured as field options for a table
    /// visual.
    order: ?[]const []const u8,

    /// The settings for the pinned columns of a table visual.
    pinned_field_options: ?TablePinnedFieldOptions,

    /// The field options to be configured to a table.
    selected_field_options: ?[]const TableFieldOption,

    /// The `TableOptions` of a transposed table.
    transposed_table_options: ?[]const TransposedTableOption,

    pub const json_field_names = .{
        .order = "Order",
        .pinned_field_options = "PinnedFieldOptions",
        .selected_field_options = "SelectedFieldOptions",
        .transposed_table_options = "TransposedTableOptions",
    };
};
