const LookbackWindowSizeUnit = @import("lookback_window_size_unit.zig").LookbackWindowSizeUnit;

/// The lookback window setup of an incremental refresh configuration.
pub const LookbackWindow = struct {
    /// The name of the lookback window column.
    column_name: []const u8,

    /// The lookback window column size.
    size: i64,

    /// The size unit that is used for the lookback window column. Valid values for
    /// this structure are `HOUR`, `DAY`, and `WEEK`.
    size_unit: LookbackWindowSizeUnit,

    pub const json_field_names = .{
        .column_name = "ColumnName",
        .size = "Size",
        .size_unit = "SizeUnit",
    };
};
