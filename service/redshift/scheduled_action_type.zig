const PauseClusterMessage = @import("pause_cluster_message.zig").PauseClusterMessage;
const ResizeClusterMessage = @import("resize_cluster_message.zig").ResizeClusterMessage;
const ResumeClusterMessage = @import("resume_cluster_message.zig").ResumeClusterMessage;

/// The action type that specifies an Amazon Redshift API operation that is
/// supported by the Amazon Redshift scheduler.
pub const ScheduledActionType = struct {
    /// An action that runs a `PauseCluster` API operation.
    pause_cluster: ?PauseClusterMessage,

    /// An action that runs a `ResizeCluster` API operation.
    resize_cluster: ?ResizeClusterMessage,

    /// An action that runs a `ResumeCluster` API operation.
    resume_cluster: ?ResumeClusterMessage,
};
