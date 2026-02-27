const ReceiverConfiguration = @import("receiver_configuration.zig").ReceiverConfiguration;
const ProtectedQueryStatus = @import("protected_query_status.zig").ProtectedQueryStatus;

/// The protected query summary for the objects listed by the request.
pub const ProtectedQuerySummary = struct {
    /// The time the protected query was created.
    create_time: i64,

    /// The unique ID of the protected query.
    id: []const u8,

    /// The unique ARN for the membership that initiated the protected query.
    membership_arn: []const u8,

    /// The unique ID for the membership that initiated the protected query.
    membership_id: []const u8,

    /// The receiver configuration.
    receiver_configurations: []const ReceiverConfiguration = &.{},

    /// The status of the protected query.
    status: ProtectedQueryStatus,

    pub const json_field_names = .{
        .create_time = "createTime",
        .id = "id",
        .membership_arn = "membershipArn",
        .membership_id = "membershipId",
        .receiver_configurations = "receiverConfigurations",
        .status = "status",
    };
};
