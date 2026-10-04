/// The calculated field of an analysis.
pub const CalculatedField = struct {
    /// The data set that is used in this calculated field.
    data_set_identifier: []const u8 = "",

    /// The expression of the calculated field.
    expression: []const u8,

    /// The name of the calculated field.
    name: []const u8,

    /// The topic that is used in this calculated field.
    topic_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_set_identifier = "DataSetIdentifier",
        .expression = "Expression",
        .name = "Name",
        .topic_identifier = "TopicIdentifier",
    };
};
