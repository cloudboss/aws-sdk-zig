/// A structure that represents a data set reference of a topic.
pub const TopicV2DataSetReference = struct {
    /// The Amazon Resource Name (ARN) of the data set.
    data_set_arn: []const u8,

    /// The name of the data set.
    data_set_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_set_arn = "DataSetArn",
        .data_set_name = "DataSetName",
    };
};
