const FlowStatus = @import("flow_status.zig").FlowStatus;

/// Contains information about a version of a flow.
///
/// This data type is used in the following API operations:
///
/// * [ListFlowVersions
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_ListFlowVersions.html#API_agent_ListFlowVersions_ResponseSyntax)
pub const FlowVersionSummary = struct {
    /// The Amazon Resource Name (ARN) of the flow that the version belongs to.
    arn: []const u8,

    /// The time at the version was created.
    created_at: i64,

    /// The unique identifier of the flow.
    id: []const u8,

    /// The status of the flow.
    status: FlowStatus,

    /// The version of the flow.
    version: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .id = "id",
        .status = "status",
        .version = "version",
    };
};
