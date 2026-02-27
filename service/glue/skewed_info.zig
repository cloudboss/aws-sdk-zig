const aws = @import("aws");

/// Specifies skewed values in a table. Skewed values are those that occur with
/// very high
/// frequency.
pub const SkewedInfo = struct {
    /// A list of names of columns that contain skewed values.
    skewed_column_names: ?[]const []const u8,

    /// A mapping of skewed values to the columns that contain them.
    skewed_column_value_location_maps: ?[]const aws.map.StringMapEntry,

    /// A list of values that appear so frequently as to be considered
    /// skewed.
    skewed_column_values: ?[]const []const u8,

    pub const json_field_names = .{
        .skewed_column_names = "SkewedColumnNames",
        .skewed_column_value_location_maps = "SkewedColumnValueLocationMaps",
        .skewed_column_values = "SkewedColumnValues",
    };
};
