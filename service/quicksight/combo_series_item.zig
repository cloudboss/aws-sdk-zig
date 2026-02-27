const DataFieldComboSeriesItem = @import("data_field_combo_series_item.zig").DataFieldComboSeriesItem;
const FieldComboSeriesItem = @import("field_combo_series_item.zig").FieldComboSeriesItem;

/// The series item configuration of a `ComboChartVisual`.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const ComboSeriesItem = struct {
    /// The data field series item configuration of a `ComboChartVisual`.
    data_field_combo_series_item: ?DataFieldComboSeriesItem,

    /// The field series item configuration of a `ComboChartVisual`.
    field_combo_series_item: ?FieldComboSeriesItem,

    pub const json_field_names = .{
        .data_field_combo_series_item = "DataFieldComboSeriesItem",
        .field_combo_series_item = "FieldComboSeriesItem",
    };
};
