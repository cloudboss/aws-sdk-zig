const StudioLifecycleConfigAppType = @import("studio_lifecycle_config_app_type.zig").StudioLifecycleConfigAppType;

/// Details of the Amazon SageMaker AI Studio Lifecycle Configuration.
pub const StudioLifecycleConfigDetails = struct {
    /// The creation time of the Amazon SageMaker AI Studio Lifecycle Configuration.
    creation_time: ?i64 = null,

    /// This value is equivalent to CreationTime because Amazon SageMaker AI Studio
    /// Lifecycle Configurations are immutable.
    last_modified_time: ?i64 = null,

    /// The App type to which the Lifecycle Configuration is attached.
    studio_lifecycle_config_app_type: ?StudioLifecycleConfigAppType = null,

    /// The Amazon Resource Name (ARN) of the Lifecycle Configuration.
    studio_lifecycle_config_arn: ?[]const u8 = null,

    /// The name of the Amazon SageMaker AI Studio Lifecycle Configuration.
    studio_lifecycle_config_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .last_modified_time = "LastModifiedTime",
        .studio_lifecycle_config_app_type = "StudioLifecycleConfigAppType",
        .studio_lifecycle_config_arn = "StudioLifecycleConfigArn",
        .studio_lifecycle_config_name = "StudioLifecycleConfigName",
    };
};
