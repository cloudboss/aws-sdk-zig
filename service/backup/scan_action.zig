const MalwareScanner = @import("malware_scanner.zig").MalwareScanner;
const ScanMode = @import("scan_mode.zig").ScanMode;

/// Defines a scanning action that specifies the malware scanner and scan mode
/// to use.
pub const ScanAction = struct {
    /// The malware scanner to use for the scan action. Currently only `GUARDDUTY`
    /// is supported.
    malware_scanner: ?MalwareScanner = null,

    /// The scanning mode to use for the scan action.
    ///
    /// Valid values: `FULL_SCAN` | `INCREMENTAL_SCAN`.
    scan_mode: ?ScanMode = null,

    pub const json_field_names = .{
        .malware_scanner = "MalwareScanner",
        .scan_mode = "ScanMode",
    };
};
