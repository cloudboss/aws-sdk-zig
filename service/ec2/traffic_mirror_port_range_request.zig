/// Information about the Traffic Mirror filter rule port range.
pub const TrafficMirrorPortRangeRequest = struct {
    /// The first port in the Traffic Mirror port range. This applies to the TCP and
    /// UDP protocols.
    from_port: ?i32 = null,

    /// The last port in the Traffic Mirror port range. This applies to the TCP and
    /// UDP protocols.
    to_port: ?i32 = null,
};
