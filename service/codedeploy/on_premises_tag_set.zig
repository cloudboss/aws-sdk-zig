const TagFilter = @import("tag_filter.zig").TagFilter;

/// Information about groups of on-premises instance tags.
pub const OnPremisesTagSet = struct {
    /// A list that contains other lists of on-premises instance tag groups. For an
    /// instance
    /// to be included in the deployment group, it must be identified by all of the
    /// tag groups
    /// in the list.
    on_premises_tag_set_list: ?[]const []const TagFilter = null,

    pub const json_field_names = .{
        .on_premises_tag_set_list = "onPremisesTagSetList",
    };
};
