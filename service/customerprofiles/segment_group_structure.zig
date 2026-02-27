const Group = @import("group.zig").Group;
const IncludeOptions = @import("include_options.zig").IncludeOptions;

/// Contains all groups of the segment definition.
pub const SegmentGroupStructure = struct {
    /// Holds the list of groups within the segment definition.
    groups: ?[]const Group,

    /// Define whether to include or exclude the profiles that fit the segment
    /// criteria.
    include: ?IncludeOptions,

    pub const json_field_names = .{
        .groups = "Groups",
        .include = "Include",
    };
};
