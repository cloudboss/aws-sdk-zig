const TagFilter = @import("tag_filter.zig").TagFilter;

/// Represents an application source.
pub const ApplicationSource = struct {
    /// The Amazon Resource Name (ARN) of a AWS CloudFormation stack.
    cloud_formation_stack_arn: ?[]const u8,

    /// A set of tags (up to 50).
    tag_filters: ?[]const TagFilter,

    pub const json_field_names = .{
        .cloud_formation_stack_arn = "CloudFormationStackARN",
        .tag_filters = "TagFilters",
    };
};
