const Ec2ScanModeState = @import("ec_2_scan_mode_state.zig").Ec2ScanModeState;
const VMScannerState = @import("vm_scanner_state.zig").VMScannerState;

/// Details about the state of the EC2 scan configuration for your environment.
pub const Ec2ConfigurationState = struct {
    /// An object that contains details about the state of the Amazon EC2 scan mode.
    scan_mode_state: ?Ec2ScanModeState = null,

    /// An object that contains details about the state of the Amazon Inspector VM
    /// scanner.
    vm_scanner_state: ?VMScannerState = null,

    pub const json_field_names = .{
        .scan_mode_state = "scanModeState",
        .vm_scanner_state = "vmScannerState",
    };
};
