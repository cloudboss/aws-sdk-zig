const Ec2ScanMode = @import("ec_2_scan_mode.zig").Ec2ScanMode;
const Ec2ScanModeStatus = @import("ec_2_scan_mode_status.zig").Ec2ScanModeStatus;

/// The state of your Amazon EC2 scan mode configuration.
pub const Ec2ScanModeState = struct {
    /// The scan method that is applied to the instance.
    scan_mode: ?Ec2ScanMode = null,

    /// The status of the Amazon EC2 scan mode setting.
    scan_mode_status: ?Ec2ScanModeStatus = null,

    pub const json_field_names = .{
        .scan_mode = "scanMode",
        .scan_mode_status = "scanModeStatus",
    };
};
