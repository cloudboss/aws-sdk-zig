const aws = @import("aws");

/// Placeholder documentation for CloudWatchAlarmTemplateGroupSummary
pub const CloudWatchAlarmTemplateGroupSummary = struct {
    /// A cloudwatch alarm template group's ARN (Amazon Resource Name)
    arn: []const u8,

    created_at: i64,

    /// A resource's optional description.
    description: ?[]const u8,

    /// A cloudwatch alarm template group's id. AWS provided template groups have
    /// ids that start with `aws-`
    id: []const u8,

    modified_at: ?i64,

    /// A resource's name. Names must be unique within the scope of a resource type
    /// in a specific region.
    name: []const u8,

    tags: ?[]const aws.map.StringMapEntry,

    /// The number of templates in a group.
    template_count: i32,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_at = "CreatedAt",
        .description = "Description",
        .id = "Id",
        .modified_at = "ModifiedAt",
        .name = "Name",
        .tags = "Tags",
        .template_count = "TemplateCount",
    };
};
