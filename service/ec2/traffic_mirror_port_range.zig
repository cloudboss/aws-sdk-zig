/// Describes the Traffic Mirror port range.
pub const TrafficMirrorPortRange = struct {
    /// The start of the Traffic Mirror port range. This applies to the TCP and UDP
    /// protocols.
    from_port: ?i32,

    /// The end of the Traffic Mirror port range. This applies to the TCP and UDP
    /// protocols.
    to_port: ?i32,
};
