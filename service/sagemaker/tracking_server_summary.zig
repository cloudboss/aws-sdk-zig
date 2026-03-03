const IsTrackingServerActive = @import("is_tracking_server_active.zig").IsTrackingServerActive;
const TrackingServerStatus = @import("tracking_server_status.zig").TrackingServerStatus;

/// The summary of the tracking server to list.
pub const TrackingServerSummary = struct {
    /// The creation time of a listed tracking server.
    creation_time: ?i64 = null,

    /// The activity status of a listed tracking server.
    is_active: ?IsTrackingServerActive = null,

    /// The last modified time of a listed tracking server.
    last_modified_time: ?i64 = null,

    /// The MLflow version used for a listed tracking server.
    mlflow_version: ?[]const u8 = null,

    /// The ARN of a listed tracking server.
    tracking_server_arn: ?[]const u8 = null,

    /// The name of a listed tracking server.
    tracking_server_name: ?[]const u8 = null,

    /// The creation status of a listed tracking server.
    tracking_server_status: ?TrackingServerStatus = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .is_active = "IsActive",
        .last_modified_time = "LastModifiedTime",
        .mlflow_version = "MlflowVersion",
        .tracking_server_arn = "TrackingServerArn",
        .tracking_server_name = "TrackingServerName",
        .tracking_server_status = "TrackingServerStatus",
    };
};
