const ProtectedJobReceiverConfiguration = @import("protected_job_receiver_configuration.zig").ProtectedJobReceiverConfiguration;
const ProtectedJobStatus = @import("protected_job_status.zig").ProtectedJobStatus;

/// The protected job summary for the objects listed by the request.
pub const ProtectedJobSummary = struct {
    /// The time the protected job was created.
    create_time: i64,

    /// The ID of the protected job.
    id: []const u8,

    /// The unique ARN for the membership that initiated the protected job.
    membership_arn: []const u8,

    /// The unique ID for the membership that initiated the protected job.
    membership_id: []const u8,

    /// The receiver configurations for the protected job.
    receiver_configurations: []const ProtectedJobReceiverConfiguration = &.{},

    /// The status of the protected job.
    status: ProtectedJobStatus,

    pub const json_field_names = .{
        .create_time = "createTime",
        .id = "id",
        .membership_arn = "membershipArn",
        .membership_id = "membershipId",
        .receiver_configurations = "receiverConfigurations",
        .status = "status",
    };
};
