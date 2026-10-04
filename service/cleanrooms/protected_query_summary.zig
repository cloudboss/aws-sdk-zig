const IntermediateTableOutputConfiguration = @import("intermediate_table_output_configuration.zig").IntermediateTableOutputConfiguration;
const ReceiverConfiguration = @import("receiver_configuration.zig").ReceiverConfiguration;
const ProtectedQueryStatus = @import("protected_query_status.zig").ProtectedQueryStatus;

/// The protected query summary for the objects listed by the request.
pub const ProtectedQuerySummary = struct {
    /// The time the protected query was created.
    create_time: i64,

    /// The unique ID of the protected query.
    id: []const u8,

    /// The intermediate table configuration, present when the protected query was
    /// triggered by a populate operation.
    intermediate_table_configuration: ?IntermediateTableOutputConfiguration = null,

    /// The unique ARN for the membership that initiated the protected query.
    membership_arn: []const u8,

    /// The unique ID for the membership that initiated the protected query.
    membership_id: []const u8,

    /// The account ID of the member that pays for the query compute costs.
    query_compute_payer_account_id: ?[]const u8 = null,

    /// The receiver configuration.
    receiver_configurations: []const ReceiverConfiguration = &.{},

    /// The status of the protected query.
    status: ProtectedQueryStatus,

    pub const json_field_names = .{
        .create_time = "createTime",
        .id = "id",
        .intermediate_table_configuration = "intermediateTableConfiguration",
        .membership_arn = "membershipArn",
        .membership_id = "membershipId",
        .query_compute_payer_account_id = "queryComputePayerAccountId",
        .receiver_configurations = "receiverConfigurations",
        .status = "status",
    };
};
