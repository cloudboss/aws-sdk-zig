const EC2TagFilter = @import("ec2_tag_filter.zig").EC2TagFilter;

/// Information about groups of Amazon EC2 instance tags.
pub const EC2TagSet = struct {
    /// A list that contains other lists of Amazon EC2 instance tag groups. For an
    /// instance to be included in the deployment group, it must be identified by
    /// all of the tag
    /// groups in the list.
    ec_2_tag_set_list: ?[]const []const EC2TagFilter = null,

    pub const json_field_names = .{
        .ec_2_tag_set_list = "ec2TagSetList",
    };
};
