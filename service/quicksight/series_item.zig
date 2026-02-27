const DataFieldSeriesItem = @import("data_field_series_item.zig").DataFieldSeriesItem;
const FieldSeriesItem = @import("field_series_item.zig").FieldSeriesItem;

/// The series item configuration of a line chart.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const SeriesItem = struct {
    /// The data field series item configuration of a line chart.
    data_field_series_item: ?DataFieldSeriesItem,

    /// The field series item configuration of a line chart.
    field_series_item: ?FieldSeriesItem,

    pub const json_field_names = .{
        .data_field_series_item = "DataFieldSeriesItem",
        .field_series_item = "FieldSeriesItem",
    };
};
