/// A structure that represents an endpoint of a data set relation of a topic.
pub const TopicV2DataSetRelationEndpoint = struct {
    /// The names of the columns that are used in the data set relation.
    column_names: []const []const u8,

    /// The Amazon Resource Name (ARN) of the data set at this endpoint of the
    /// relation.
    data_set_arn: []const u8,

    pub const json_field_names = .{
        .column_names = "ColumnNames",
        .data_set_arn = "DataSetArn",
    };
};
