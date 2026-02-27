/// A data set.
pub const DataSetIdentifierDeclaration = struct {
    /// The Amazon Resource Name (ARN) of the data set.
    data_set_arn: []const u8,

    /// The identifier of the data set, typically the data set's name.
    identifier: []const u8,

    pub const json_field_names = .{
        .data_set_arn = "DataSetArn",
        .identifier = "Identifier",
    };
};
