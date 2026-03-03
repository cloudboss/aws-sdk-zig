const CapabilityReportEndpoint = @import("capability_report_endpoint.zig").CapabilityReportEndpoint;

/// Report of all capabilities supported by the device.
pub const CapabilityReport = struct {
    /// The endpoints used in the capability report.
    endpoints: []const CapabilityReportEndpoint,

    /// The numeric identifier of the node.
    node_id: ?[]const u8 = null,

    /// The version of the capability report.
    version: []const u8,

    pub const json_field_names = .{
        .endpoints = "endpoints",
        .node_id = "nodeId",
        .version = "version",
    };
};
