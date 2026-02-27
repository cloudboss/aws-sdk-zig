const MlflowAppStatus = @import("mlflow_app_status.zig").MlflowAppStatus;

/// The summary of the Mlflow App to list.
pub const MlflowAppSummary = struct {
    /// The ARN of a listed MLflow App.
    arn: ?[]const u8,

    /// The creation time of a listed MLflow App.
    creation_time: ?i64,

    /// The last modified time of a listed MLflow App.
    last_modified_time: ?i64,

    /// The version of a listed MLflow App.
    mlflow_version: ?[]const u8,

    /// The name of the MLflow App.
    name: ?[]const u8,

    /// The status of the MLflow App.
    status: ?MlflowAppStatus,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .last_modified_time = "LastModifiedTime",
        .mlflow_version = "MlflowVersion",
        .name = "Name",
        .status = "Status",
    };
};
