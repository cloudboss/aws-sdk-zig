const IpProtocol = @import("ip_protocol.zig").IpProtocol;

/// A range of IP addresses and port settings that allow inbound traffic to
/// connect to
/// processes on an instance in a fleet. Processes are assigned an IP
/// address/port number
/// combination, which must fall into the fleet's allowed ranges.
///
/// For Amazon GameLift Servers Realtime fleets, Amazon GameLift Servers
/// automatically opens two port ranges, one for TCP messaging
/// and one for UDP.
pub const IpPermission = struct {
    /// A starting value for a range of allowed port numbers.
    ///
    /// For fleets using Linux builds, only ports `22` and `1026-60000` are valid.
    ///
    /// For fleets using Windows builds, only ports `1026-60000` are valid.
    from_port: i32,

    /// A range of allowed IP addresses. This value must be expressed in CIDR
    /// notation.
    /// Example: "`000.000.000.000/[subnet mask]`" or optionally the shortened
    /// version "`0.0.0.0/[subnet mask]`".
    ip_range: []const u8,

    /// The network communication protocol used by the fleet.
    protocol: IpProtocol,

    /// An ending value for a range of allowed port numbers. Port numbers are
    /// end-inclusive.
    /// This value must be equal to or greater than `FromPort`.
    ///
    /// For fleets using Linux builds, only ports `22` and `1026-60000` are valid.
    ///
    /// For fleets using Windows builds, only ports `1026-60000` are valid.
    to_port: i32,

    pub const json_field_names = .{
        .from_port = "FromPort",
        .ip_range = "IpRange",
        .protocol = "Protocol",
        .to_port = "ToPort",
    };
};
