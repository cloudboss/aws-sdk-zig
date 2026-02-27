const FlowStatus = @import("flow_status.zig").FlowStatus;

/// Contains the definition of a flow.
pub const FlowSummary = struct {
    /// The Amazon Resource Name (ARN) of the flow.
    arn: []const u8,

    /// The time at which the flow was created.
    created_at: i64,

    /// A description of the flow.
    description: ?[]const u8,

    /// The unique identifier of the flow.
    id: []const u8,

    /// The name of the flow.
    name: []const u8,

    /// The status of the flow. The following statuses are possible:
    ///
    /// * NotPrepared – The flow has been created or updated, but hasn't been
    ///   prepared. If you just created the flow, you can't test it. If you updated
    ///   the flow, the `DRAFT` version won't contain the latest changes for
    ///   testing. Send a
    ///   [PrepareFlow](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_PrepareFlow.html) request to package the latest changes into the `DRAFT` version.
    /// * Preparing – The flow is being prepared so that the `DRAFT` version
    ///   contains the latest changes for testing.
    /// * Prepared – The flow is prepared and the `DRAFT` version contains the
    ///   latest changes for testing.
    /// * Failed – The last API operation that you invoked on the flow failed. Send
    ///   a
    ///   [GetFlow](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_GetFlow.html) request and check the error message in the `validations` field.
    status: FlowStatus,

    /// The time at which the flow was last updated.
    updated_at: i64,

    /// The latest version of the flow.
    version: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .description = "description",
        .id = "id",
        .name = "name",
        .status = "status",
        .updated_at = "updatedAt",
        .version = "version",
    };
};
