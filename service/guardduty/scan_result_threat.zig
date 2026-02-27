const ItemDetails = @import("item_details.zig").ItemDetails;
const DetectionSource = @import("detection_source.zig").DetectionSource;

/// Contains information about a specific threat that was detected during the
/// malware scan.
pub const ScanResultThreat = struct {
    /// The number of instances of this threat that were detected.
    count: ?i64,

    /// The hash value associated with the detected threat.
    hash: ?[]const u8,

    /// Additional information about where this threat was detected.
    item_details: ?[]const ItemDetails,

    /// The name of the detected threat.
    name: ?[]const u8,

    /// The source that detected this threat.
    source: ?DetectionSource,

    pub const json_field_names = .{
        .count = "Count",
        .hash = "Hash",
        .item_details = "ItemDetails",
        .name = "Name",
        .source = "Source",
    };
};
