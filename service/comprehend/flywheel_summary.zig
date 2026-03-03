const ModelType = @import("model_type.zig").ModelType;
const FlywheelStatus = @import("flywheel_status.zig").FlywheelStatus;

/// Flywheel summary information.
pub const FlywheelSummary = struct {
    /// ARN of the active model version for the flywheel.
    active_model_arn: ?[]const u8 = null,

    /// Creation time of the flywheel.
    creation_time: ?i64 = null,

    /// Amazon S3 URI of the data lake location.
    data_lake_s3_uri: ?[]const u8 = null,

    /// The Amazon Resource Number (ARN) of the flywheel
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

    pub const json_field_names = .{
        .active_model_arn = "ActiveModelArn",
        .creation_time = "CreationTime",
        .data_lake_s3_uri = "DataLakeS3Uri",
        .flywheel_arn = "FlywheelArn",
        .last_modified_time = "LastModifiedTime",
        .latest_flywheel_iteration = "LatestFlywheelIteration",
        .message = "Message",
        .model_type = "ModelType",
        .status = "Status",
    };
};
