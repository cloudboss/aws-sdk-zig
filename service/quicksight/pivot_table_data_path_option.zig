const DataPathValue = @import("data_path_value.zig").DataPathValue;

/// The data path options for the pivot table field options.
pub const PivotTableDataPathOption = struct {
    /// The list of data path values for the data path options.
    data_path_list: []const DataPathValue,

    /// The width of the data path option.
    width: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_path_list = "DataPathList",
        .width = "Width",
    };
};
