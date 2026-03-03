const CodeSecurityResource = @import("code_security_resource.zig").CodeSecurityResource;

/// A summary of an association between a code repository and a scan
/// configuration.
pub const CodeSecurityScanConfigurationAssociationSummary = struct {
    resource: ?CodeSecurityResource = null,

    pub const json_field_names = .{
        .resource = "resource",
    };
};
