const VMScannerStatus = @import("vm_scanner_status.zig").VMScannerStatus;

/// The state of the Amazon Inspector VM scanner.
pub const VMScannerState = struct {
    /// Whether the VM scanner is activated.
    activated: ?bool = null,

    /// The date and time the VM scanner was activated.
    activated_at: ?i64 = null,

    /// The status of the VM scanner.
    status: ?VMScannerStatus = null,

    pub const json_field_names = .{
        .activated = "activated",
        .activated_at = "activatedAt",
        .status = "status",
    };
};
