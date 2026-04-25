const aws = @import("aws");

const ScanCondition = @import("scan_condition.zig").ScanCondition;

/// Contains information about criteria used to filter resources before
/// triggering malware scan.
pub const ScanResourceCriteria = struct {
    /// Represents condition that when matched will prevent a malware scan for a
    /// certain resource.
    exclude: ?[]const aws.map.MapEntry(ScanCondition) = null,

    /// Represents condition that when matched will allow a malware scan for a
    /// certain resource.
    include: ?[]const aws.map.MapEntry(ScanCondition) = null,

    pub const json_field_names = .{
        .exclude = "Exclude",
        .include = "Include",
    };
};
