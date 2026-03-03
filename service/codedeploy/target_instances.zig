const EC2TagSet = @import("ec2_tag_set.zig").EC2TagSet;
const EC2TagFilter = @import("ec2_tag_filter.zig").EC2TagFilter;

/// Information about the instances to be used in the replacement environment in
/// a
/// blue/green deployment.
pub const TargetInstances = struct {
    /// The names of one or more Auto Scaling groups to identify a replacement
    /// environment for a blue/green deployment.
    auto_scaling_groups: ?[]const []const u8 = null,

    /// Information about the groups of Amazon EC2 instance tags that an instance
    /// must
    /// be identified by in order for it to be included in the replacement
    /// environment for a
    /// blue/green deployment. Cannot be used in the same call as
    /// `tagFilters`.
    ec_2_tag_set: ?EC2TagSet = null,

    /// The tag filter key, type, and value used to identify Amazon EC2 instances in
    /// a
    /// replacement environment for a blue/green deployment. Cannot be used in the
    /// same call as
    /// `ec2TagSet`.
    tag_filters: ?[]const EC2TagFilter = null,

    pub const json_field_names = .{
        .auto_scaling_groups = "autoScalingGroups",
        .ec_2_tag_set = "ec2TagSet",
        .tag_filters = "tagFilters",
    };
};
