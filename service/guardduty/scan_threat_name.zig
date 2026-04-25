const ScanFilePath = @import("scan_file_path.zig").ScanFilePath;

/// Contains files infected with the given threat providing details of malware
/// name and severity.
pub const ScanThreatName = struct {
    /// List of infected files in EBS volume with details.
    file_paths: ?[]const ScanFilePath = null,

    /// Total number of files infected with given threat.
    item_count: ?i32 = null,

    /// The name of the identified threat.
    name: ?[]const u8 = null,

    /// Severity of threat identified as part of the malware scan.
    severity: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_paths = "FilePaths",
        .item_count = "ItemCount",
        .name = "Name",
        .severity = "Severity",
    };
};
