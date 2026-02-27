/// The rolling date configuration of a date time filter.
pub const RollingDateConfiguration = struct {
    /// The data set that is used in the rolling date configuration.
    data_set_identifier: ?[]const u8,

    /// The expression of the rolling date configuration.
    expression: []const u8,

    pub const json_field_names = .{
        .data_set_identifier = "DataSetIdentifier",
        .expression = "Expression",
    };
};
