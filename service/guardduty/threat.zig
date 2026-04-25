const ItemDetails = @import("item_details.zig").ItemDetails;
const ItemPath = @import("item_path.zig").ItemPath;

/// Information about the detected threats associated with the generated
/// finding.
pub const Threat = struct {
    /// The number of occurrences of this specific threat detected during the scan.
    count: ?i64 = null,

    /// The hash identifier of the detected malware threat.
    hash: ?[]const u8 = null,

    /// Detailed information about the detected malware threat.
    item_details: ?[]const ItemDetails = null,

    /// Information about the nested item path and hash of the protected resource.
    item_paths: ?[]const ItemPath = null,

    /// Name of the detected threat that caused GuardDuty to generate this finding.
    name: ?[]const u8 = null,

    /// Source of the threat that generated this finding.
    source: ?[]const u8 = null,

    pub const json_field_names = .{
        .count = "Count",
        .hash = "Hash",
        .item_details = "ItemDetails",
        .item_paths = "ItemPaths",
        .name = "Name",
        .source = "Source",
    };
};
