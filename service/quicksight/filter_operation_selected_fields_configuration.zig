const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;
const SelectedFieldOptions = @import("selected_field_options.zig").SelectedFieldOptions;

/// The configuration of selected fields in the`CustomActionFilterOperation`.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const FilterOperationSelectedFieldsConfiguration = struct {
    /// The selected columns of a dataset.
    selected_columns: ?[]const ColumnIdentifier = null,

    /// A structure that contains the options that choose which fields are filtered
    /// in the `CustomActionFilterOperation`.
    ///
    /// Valid values are defined as follows:
    ///
    /// * `ALL_FIELDS`: Applies the filter operation to all fields.
    selected_field_options: ?SelectedFieldOptions = null,

    /// Chooses the fields that are filtered in `CustomActionFilterOperation`.
    selected_fields: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .selected_columns = "SelectedColumns",
        .selected_field_options = "SelectedFieldOptions",
        .selected_fields = "SelectedFields",
    };
};
