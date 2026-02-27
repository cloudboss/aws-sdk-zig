/// Metadata attributes of the time series that are written in each measure
/// record.
pub const TimestreamDimension = struct {
    /// The metadata dimension name. This is the name of the column in the
    /// Amazon Timestream database table record.
    ///
    /// Dimensions cannot be named: `measure_name`,
    /// `measure_value`, or `time`.
    /// These names are reserved. Dimension names cannot start
    /// with `ts_` or `measure_value` and
    /// they cannot contain the colon (`:`)
    /// character.
    name: []const u8,

    /// The value to write in this column of the database record.
    value: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
