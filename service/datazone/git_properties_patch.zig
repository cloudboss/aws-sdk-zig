/// The properties used to update an existing Git connection, such as the
/// CodeConnections ARN or the default branch.
pub const GitPropertiesPatch = struct {
    /// The ARN of the CodeConnections connection used to connect to the Git
    /// repository.
    code_connection_arn: ?[]const u8 = null,

    /// The default branch of the Git repository.
    default_branch: ?[]const u8 = null,

    pub const json_field_names = .{
        .code_connection_arn = "codeConnectionArn",
        .default_branch = "defaultBranch",
    };
};
