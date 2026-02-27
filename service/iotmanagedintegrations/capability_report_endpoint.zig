const CapabilityReportCapability = @import("capability_report_capability.zig").CapabilityReportCapability;

/// The endpoint used in the capability report.
pub const CapabilityReportEndpoint = struct {
    /// The capabilities used in the capability report.
    capabilities: []const CapabilityReportCapability,

    /// The type of device.
    device_types: []const []const u8,

    /// The id of the endpoint used in the capability report.
    id: []const u8,

    pub const json_field_names = .{
        .capabilities = "capabilities",
        .device_types = "deviceTypes",
        .id = "id",
    };
};
