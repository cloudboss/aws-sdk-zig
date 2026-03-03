const SegmentGroup = @import("segment_group.zig").SegmentGroup;
const Include = @import("include.zig").Include;

/// Specifies the settings that define the relationships between segment groups
/// for a segment.
pub const SegmentGroupList = struct {
    /// An array that defines the set of segment criteria to evaluate when handling
    /// segment groups for the segment.
    groups: ?[]const SegmentGroup = null,

    /// Specifies how to handle multiple segment groups for the segment. For
    /// example, if the segment includes three segment groups, whether the resulting
    /// segment includes endpoints that match all, any, or none of the segment
    /// groups.
    include: ?Include = null,

    pub const json_field_names = .{
        .groups = "Groups",
        .include = "Include",
    };
};
