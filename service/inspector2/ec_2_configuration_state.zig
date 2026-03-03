const Ec2ScanModeState = @import("ec_2_scan_mode_state.zig").Ec2ScanModeState;

/// Details about the state of the EC2 scan configuration for your environment.
pub const Ec2ConfigurationState = struct {
    /// An object that contains details about the state of the Amazon EC2 scan mode.
    scan_mode_state: ?Ec2ScanModeState = null,

    pub const json_field_names = .{
        .scan_mode_state = "scanModeState",
    };
};
