pub const StreamState = enum {
    stream_live,
    stream_offline,

    pub const json_field_names = .{
        .stream_live = "StreamLive",
        .stream_offline = "StreamOffline",
    };
};
