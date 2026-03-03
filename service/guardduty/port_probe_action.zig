const PortProbeDetail = @import("port_probe_detail.zig").PortProbeDetail;

/// Contains information about the PORT_PROBE action described in the finding.
pub const PortProbeAction = struct {
    /// Indicates whether EC2 blocked the port probe to the instance, such as with
    /// an ACL.
    blocked: ?bool = null,

    /// A list of objects related to port probe details.
    port_probe_details: ?[]const PortProbeDetail = null,

    pub const json_field_names = .{
        .blocked = "Blocked",
        .port_probe_details = "PortProbeDetails",
    };
};
