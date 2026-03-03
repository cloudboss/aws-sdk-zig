const PortProbeDetail = @import("port_probe_detail.zig").PortProbeDetail;

/// Provided if `ActionType` is `PORT_PROBE`. It provides details
/// about the attempted port probe that was detected.
pub const PortProbeAction = struct {
    /// Indicates whether the port probe was blocked.
    blocked: ?bool = null,

    /// Information about the ports affected by the port probe.
    port_probe_details: ?[]const PortProbeDetail = null,

    pub const json_field_names = .{
        .blocked = "Blocked",
        .port_probe_details = "PortProbeDetails",
    };
};
