pub const CreateIndexResponse = struct {
    /// The Amazon Resource Name (ARN) of an Amazon Q Business index.
    index_arn: ?[]const u8,

    /// The identifier for the Amazon Q Business index.
    index_id: ?[]const u8,

    pub const json_field_names = .{
        .index_arn = "indexArn",
        .index_id = "indexId",
    };
};
