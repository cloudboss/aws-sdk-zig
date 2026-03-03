/// Summary information about various endpoints for a stage. We recommend that
/// you cache
/// these values at stage creation; the values can be cached for up to 14 days.
pub const StageEndpoints = struct {
    /// Events endpoint.
    events: ?[]const u8 = null,

    /// The endpoint to be used for IVS real-time streaming using the RTMP protocol.
    rtmp: ?[]const u8 = null,

    /// The endpoint to be used for IVS real-time streaming using the RTMPS
    /// protocol.
    rtmps: ?[]const u8 = null,

    /// The endpoint to be used for IVS real-time streaming using the WHIP protocol.
    whip: ?[]const u8 = null,

    pub const json_field_names = .{
        .events = "events",
        .rtmp = "rtmp",
        .rtmps = "rtmps",
        .whip = "whip",
    };
};
