const ConformancePackState = @import("conformance_pack_state.zig").ConformancePackState;

/// Status details of a conformance pack.
pub const ConformancePackStatusDetail = struct {
    /// Amazon Resource Name (ARN) of comformance pack.
    conformance_pack_arn: []const u8,

    /// ID of the conformance pack.
    conformance_pack_id: []const u8,

    /// Name of the conformance pack.
    conformance_pack_name: []const u8,

    /// Indicates deployment status of conformance pack.
    ///
    /// Config sets the state of the conformance pack to:
    ///
    /// * CREATE_IN_PROGRESS when a conformance pack creation is in progress for an
    ///   account.
    ///
    /// * CREATE_COMPLETE when a conformance pack has been successfully created in
    ///   your account.
    ///
    /// * CREATE_FAILED when a conformance pack creation failed in your account.
    ///
    /// * DELETE_IN_PROGRESS when a conformance pack deletion is in progress.
    ///
    /// * DELETE_FAILED when a conformance pack deletion failed in your account.
    conformance_pack_state: ConformancePackState,

    /// The reason of conformance pack creation failure.
    conformance_pack_status_reason: ?[]const u8 = null,

    /// Last time when conformation pack creation and update was successful.
    last_update_completed_time: ?i64 = null,

    /// Last time when conformation pack creation and update was requested.
    last_update_requested_time: i64,

    /// Amazon Resource Name (ARN) of CloudFormation stack.
    stack_arn: []const u8,

    pub const json_field_names = .{
        .conformance_pack_arn = "ConformancePackArn",
        .conformance_pack_id = "ConformancePackId",
        .conformance_pack_name = "ConformancePackName",
        .conformance_pack_state = "ConformancePackState",
        .conformance_pack_status_reason = "ConformancePackStatusReason",
        .last_update_completed_time = "LastUpdateCompletedTime",
        .last_update_requested_time = "LastUpdateRequestedTime",
        .stack_arn = "StackArn",
    };
};
