/// Describes an association between an app block builder and app block.
pub const AppBlockBuilderAppBlockAssociation = struct {
    /// The ARN of the app block.
    app_block_arn: []const u8,

    /// The name of the app block builder.
    app_block_builder_name: []const u8,

    pub const json_field_names = .{
        .app_block_arn = "AppBlockArn",
        .app_block_builder_name = "AppBlockBuilderName",
    };
};
