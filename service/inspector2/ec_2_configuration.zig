const Ec2ScanMode = @import("ec_2_scan_mode.zig").Ec2ScanMode;

/// Enables agent-based scanning, which scans instances that are not managed by
/// SSM.
pub const Ec2Configuration = struct {
    /// The scan method that is applied to the instance.
    scan_mode: Ec2ScanMode,

    pub const json_field_names = .{
        .scan_mode = "scanMode",
    };
};
