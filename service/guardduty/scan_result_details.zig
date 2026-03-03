const ScanResult = @import("scan_result.zig").ScanResult;

/// Represents the result of the scan.
pub const ScanResultDetails = struct {
    /// An enum value representing possible scan results.
    scan_result: ?ScanResult = null,

    pub const json_field_names = .{
        .scan_result = "ScanResult",
    };
};
