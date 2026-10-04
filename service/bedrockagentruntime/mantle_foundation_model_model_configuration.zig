/// Model configuration for a Mantle foundation model.
pub const MantleFoundationModelModelConfiguration = struct {
    /// The ARN of the Mantle foundation model.
    model_arn: []const u8,

    /// The Amazon Bedrock project ID used for billing and usage attribution. If you
    /// don't specify a value, the service uses the default project.
    project_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .model_arn = "modelArn",
        .project_id = "projectId",
    };
};
