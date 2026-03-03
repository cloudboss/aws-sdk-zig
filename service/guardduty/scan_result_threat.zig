const ItemDetails = @import("item_details.zig").ItemDetails;
const DetectionSource = @import("detection_source.zig").DetectionSource;

/// Contains information about a specific threat that was detected during the
/// malware scan.
pub const ScanResultThreat = struct {
    /// The number of instances of this threat that were detected.
    count: ?i64 = null,

    /// The hash value associated with the detected threat.
    hash: ?[]const u8 = null,

    /// Additional information about where this threat was detected.
    item_details: ?[]const ItemDetails = null,

    /// The name of the detected threat.
    name: ?[]const u8 = null,

    /// The source that detected this threat.
    source: ?DetectionSource = null,

    pub const json_field_names = .{
        .count = "Count",
        .hash = "Hash",
        .item_details = "ItemDetails",
        .name = "Name",
        .source = "Source",
    };
};
