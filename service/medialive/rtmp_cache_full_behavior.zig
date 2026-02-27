/// Rtmp Cache Full Behavior
pub const RtmpCacheFullBehavior = enum {
    disconnect_immediately,
    wait_for_server,

    pub const json_field_names = .{
        .disconnect_immediately = "DISCONNECT_IMMEDIATELY",
        .wait_for_server = "WAIT_FOR_SERVER",
    };
};
