const HumanLoopStatus = @import("human_loop_status.zig").HumanLoopStatus;

/// Summary information about the human loop.
pub const HumanLoopSummary = struct {
    /// When Amazon Augmented AI created the human loop.
    creation_time: ?i64 = null,

    /// The reason why the human loop failed. A failure reason is returned when the
    /// status of the
    /// human loop is `Failed`.
    failure_reason: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the flow definition used to configure the
    /// human
    /// loop.
    flow_definition_arn: ?[]const u8 = null,

    /// The name of the human loop.
    human_loop_name: ?[]const u8 = null,

    /// The status of the human loop.
    human_loop_status: ?HumanLoopStatus = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .failure_reason = "FailureReason",
        .flow_definition_arn = "FlowDefinitionArn",
        .human_loop_name = "HumanLoopName",
        .human_loop_status = "HumanLoopStatus",
    };
};
