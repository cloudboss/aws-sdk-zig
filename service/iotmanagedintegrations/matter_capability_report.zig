const MatterCapabilityReportEndpoint = @import("matter_capability_report_endpoint.zig").MatterCapabilityReportEndpoint;

/// Matter based capability report.
pub const MatterCapabilityReport = struct {
    /// The endpoints used in the capability report.
    endpoints: []const MatterCapabilityReportEndpoint,

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
