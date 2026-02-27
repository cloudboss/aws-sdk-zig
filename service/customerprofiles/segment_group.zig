const Group = @import("group.zig").Group;
const IncludeOptions = @import("include_options.zig").IncludeOptions;

/// Contains all groups of the segment definition.
pub const SegmentGroup = struct {
    /// Holds the list of groups within the segment definition.
    groups: ?[]const Group,

    /// Defines whether to include or exclude the profiles that fit the segment
    /// criteria.
    include: IncludeOptions = "ALL",

    pub const json_field_names = .{
        .groups = "Groups",
        .include = "Include",
    };
};
