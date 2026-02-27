const RegistryScanningRule = @import("registry_scanning_rule.zig").RegistryScanningRule;
const ScanType = @import("scan_type.zig").ScanType;

/// The scanning configuration for a private registry.
pub const RegistryScanningConfiguration = struct {
    /// The scanning rules associated with the registry.
    rules: ?[]const RegistryScanningRule,

    /// The type of scanning configured for the registry.
    scan_type: ?ScanType,

    pub const json_field_names = .{
        .rules = "rules",
        .scan_type = "scanType",
    };
};
