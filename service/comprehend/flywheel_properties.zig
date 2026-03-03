const DataSecurityConfig = @import("data_security_config.zig").DataSecurityConfig;
const ModelType = @import("model_type.zig").ModelType;
const FlywheelStatus = @import("flywheel_status.zig").FlywheelStatus;
const TaskConfig = @import("task_config.zig").TaskConfig;

/// The flywheel properties.
pub const FlywheelProperties = struct {
    /// The Amazon Resource Number (ARN) of the active model version.
    active_model_arn: ?[]const u8 = null,

    /// Creation time of the flywheel.
    creation_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the IAM role that
    /// grants Amazon Comprehend permission to access the flywheel data.
    data_access_role_arn: ?[]const u8 = null,

    /// Amazon S3 URI of the data lake location.
    data_lake_s3_uri: ?[]const u8 = null,

    /// Data security configuration.
    data_security_config: ?DataSecurityConfig = null,

    /// The Amazon Resource Number (ARN) of the flywheel.
    flywheel_arn: ?[]const u8 = null,

    /// Last modified time for the flywheel.
    last_modified_time: ?i64 = null,

    /// The most recent flywheel iteration.
    latest_flywheel_iteration: ?[]const u8 = null,

    /// A description of the status of the flywheel.
    message: ?[]const u8 = null,

    /// Model type of the flywheel's model.
    model_type: ?ModelType = null,

    /// The status of the flywheel.
    status: ?FlywheelStatus = null,

    /// Configuration about the model associated with a flywheel.
    task_config: ?TaskConfig = null,

    pub const json_field_names = .{
        .active_model_arn = "ActiveModelArn",
        .creation_time = "CreationTime",
        .data_access_role_arn = "DataAccessRoleArn",
        .data_lake_s3_uri = "DataLakeS3Uri",
        .data_security_config = "DataSecurityConfig",
        .flywheel_arn = "FlywheelArn",
        .last_modified_time = "LastModifiedTime",
        .latest_flywheel_iteration = "LatestFlywheelIteration",
        .message = "Message",
        .model_type = "ModelType",
        .status = "Status",
        .task_config = "TaskConfig",
    };
};
