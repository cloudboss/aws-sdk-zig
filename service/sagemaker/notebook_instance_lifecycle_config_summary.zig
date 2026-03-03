/// Provides a summary of a notebook instance lifecycle configuration.
pub const NotebookInstanceLifecycleConfigSummary = struct {
    /// A timestamp that tells when the lifecycle configuration was created.
    creation_time: ?i64 = null,

    /// A timestamp that tells when the lifecycle configuration was last modified.
    last_modified_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the lifecycle configuration.
    notebook_instance_lifecycle_config_arn: []const u8,

    /// The name of the lifecycle configuration.
    notebook_instance_lifecycle_config_name: []const u8,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .last_modified_time = "LastModifiedTime",
        .notebook_instance_lifecycle_config_arn = "NotebookInstanceLifecycleConfigArn",
        .notebook_instance_lifecycle_config_name = "NotebookInstanceLifecycleConfigName",
    };
};
