const MalwareScanner = @import("malware_scanner.zig").MalwareScanner;

/// Contains configuration settings for malware scanning, including the scanner
/// type, target resource types, and scanner role.
pub const ScanSetting = struct {
    /// The malware scanner to use for scanning. Currently only `GUARDDUTY` is
    /// supported.
    malware_scanner: ?MalwareScanner,

    /// An array of resource types to be scanned for malware.
    resource_types: ?[]const []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role that the scanner uses to
    /// access resources; for example,
    /// `arn:aws:iam::123456789012:role/ScannerRole`.
    scanner_role_arn: ?[]const u8,

    pub const json_field_names = .{
        .malware_scanner = "MalwareScanner",
        .resource_types = "ResourceTypes",
        .scanner_role_arn = "ScannerRoleArn",
    };
};
