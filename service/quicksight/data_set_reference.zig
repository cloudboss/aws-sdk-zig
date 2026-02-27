/// Dataset reference.
pub const DataSetReference = struct {
    /// Dataset Amazon Resource Name (ARN).
    data_set_arn: []const u8,

    /// Dataset placeholder.
    data_set_placeholder: []const u8,

    pub const json_field_names = .{
        .data_set_arn = "DataSetArn",
        .data_set_placeholder = "DataSetPlaceholder",
    };
};
