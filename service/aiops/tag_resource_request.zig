const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource that you want to apply the
    /// tags to. You can use the `ListInvestigationGroups` operation to find the
    /// ARNs of investigation groups.
    resource_arn: []const u8,

    /// The list of key-value pairs to associate with the resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
