const DataPathValue = @import("data_path_value.zig").DataPathValue;
const TimeGranularity = @import("time_granularity.zig").TimeGranularity;

/// The color map that determines the color options for a particular element.
pub const DataPathColor = struct {
    /// The color that needs to be applied to the element.
    color: []const u8,

    /// The element that the color needs to be applied to.
    element: DataPathValue,

    /// The time granularity of the field that the color needs to be applied to.
    time_granularity: ?TimeGranularity = null,

    pub const json_field_names = .{
        .color = "Color",
        .element = "Element",
        .time_granularity = "TimeGranularity",
    };
};
