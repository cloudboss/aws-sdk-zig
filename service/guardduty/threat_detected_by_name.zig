const ScanThreatName = @import("scan_threat_name.zig").ScanThreatName;

/// Contains details about identified threats organized by threat name.
pub const ThreatDetectedByName = struct {
    /// Total number of infected files identified.
    item_count: ?i32 = null,

    /// Flag to determine if the finding contains every single infected file-path
    /// and/or every
    /// threat.
    shortened: ?bool = null,

    /// List of identified threats with details, organized by threat name.
    threat_names: ?[]const ScanThreatName = null,

    /// Total number of unique threats by name identified, as part of the malware
    /// scan.
    unique_threat_name_count: ?i32 = null,

    pub const json_field_names = .{
        .item_count = "ItemCount",
        .shortened = "Shortened",
        .threat_names = "ThreatNames",
        .unique_threat_name_count = "UniqueThreatNameCount",
    };
};
