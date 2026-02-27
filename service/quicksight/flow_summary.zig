const FlowPublishState = @import("flow_publish_state.zig").FlowPublishState;

/// The basic information of the flow exluding its definition specifying the
/// steps.
pub const FlowSummary = struct {
    /// The Amazon Resource Name (ARN) of the flow.
    arn: []const u8,

    /// The identifier of the principal who created the flow.
    created_by: ?[]const u8,

    /// The time this flow was created.
    created_time: i64,

    /// The description of the flow.
    description: ?[]const u8,

    /// The unique identifier of the flow.
    flow_id: []const u8,

    /// The last time this flow was published.
    last_published_at: ?i64,

    /// The identifier of the last principal who published the flow.
    last_published_by: ?[]const u8,

    /// The identifier of the last principal who updated the flow.
    last_updated_by: ?[]const u8,

    /// The last time this flow was modified.
    last_updated_time: ?i64,

    /// The display name of the flow.
    name: []const u8,

    /// The publish state for the flow. The valid values are `DRAFT`, `PUBLISHED`,
    /// or `PENDING_APPROVAL`.
    publish_state: ?FlowPublishState,

    /// The number of runs done for the flow.
    run_count: i32 = 0,

    /// The number of users who have used the flow.
    user_count: i32 = 0,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_by = "CreatedBy",
        .created_time = "CreatedTime",
        .description = "Description",
        .flow_id = "FlowId",
        .last_published_at = "LastPublishedAt",
        .last_published_by = "LastPublishedBy",
        .last_updated_by = "LastUpdatedBy",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .publish_state = "PublishState",
        .run_count = "RunCount",
        .user_count = "UserCount",
    };
};
