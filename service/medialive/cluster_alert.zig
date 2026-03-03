const ClusterAlertState = @import("cluster_alert_state.zig").ClusterAlertState;

/// An alert on a cluster
pub const ClusterAlert = struct {
    /// The type of the alert
    alert_type: ?[]const u8 = null,

    /// The ID of the channel this alert is associated with
    channel_id: ?[]const u8 = null,

    /// The time when the alert was cleared
    cleared_timestamp: ?i64 = null,

    /// The further subtype of this alert
    id: ?[]const u8 = null,

    /// The user facing alert message which can have more context
    message: ?[]const u8 = null,

    /// The ID of the node this alert is associated with
    node_id: ?[]const u8 = null,

    /// The time when the alert was set
    set_timestamp: ?i64 = null,

    /// The state of the alert
    state: ?ClusterAlertState = null,

    pub const json_field_names = .{
        .alert_type = "AlertType",
        .channel_id = "ChannelId",
        .cleared_timestamp = "ClearedTimestamp",
        .id = "Id",
        .message = "Message",
        .node_id = "NodeId",
        .set_timestamp = "SetTimestamp",
        .state = "State",
    };
};
