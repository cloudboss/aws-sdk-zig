const MultiplexAlertState = @import("multiplex_alert_state.zig").MultiplexAlertState;

/// An alert on a multiplex
pub const MultiplexAlert = struct {
    /// The type of the alert
    alert_type: ?[]const u8 = null,

    /// The time when the alert was cleared
    cleared_timestamp: ?i64 = null,

    /// The unique ID for this alert instance
    id: ?[]const u8 = null,

    /// The user facing alert message which can have more context
    message: ?[]const u8 = null,

    /// The ID of the pipeline this alert is associated with
    pipeline_id: ?[]const u8 = null,

    /// The time when the alert was set
    set_timestamp: ?i64 = null,

    /// The state of the alert
    state: ?MultiplexAlertState = null,

    pub const json_field_names = .{
        .alert_type = "AlertType",
        .cleared_timestamp = "ClearedTimestamp",
        .id = "Id",
        .message = "Message",
        .pipeline_id = "PipelineId",
        .set_timestamp = "SetTimestamp",
        .state = "State",
    };
};
