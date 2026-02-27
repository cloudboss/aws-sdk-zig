const DataFieldBarSeriesItem = @import("data_field_bar_series_item.zig").DataFieldBarSeriesItem;
const FieldBarSeriesItem = @import("field_bar_series_item.zig").FieldBarSeriesItem;

/// The series item configuration of a `BarChartVisual`.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const BarSeriesItem = struct {
    /// The data field series item configuration of a `BarChartVisual`.
    data_field_bar_series_item: ?DataFieldBarSeriesItem,

    /// The field series item configuration of a `BarChartVisual`.
    field_bar_series_item: ?FieldBarSeriesItem,

    pub const json_field_names = .{
        .data_field_bar_series_item = "DataFieldBarSeriesItem",
        .field_bar_series_item = "FieldBarSeriesItem",
    };
};
