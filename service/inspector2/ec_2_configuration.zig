const Ec2ScanMode = @import("ec_2_scan_mode.zig").Ec2ScanMode;

/// Enables agent-based scanning, which scans instances that are not managed by
/// SSM.
pub const Ec2Configuration = struct {
    /// Whether to activate Amazon Inspector VM scanner for Amazon EC2 scanning.
    activate_vm_scanner: ?bool = null,

    /// The scan method that is applied to the instance.
    scan_mode: Ec2ScanMode,

    pub const json_field_names = .{
        .activate_vm_scanner = "activateVMScanner",
        .scan_mode = "scanMode",
    };
};
