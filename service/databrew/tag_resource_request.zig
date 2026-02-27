const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The DataBrew resource to which tags should be added. The value for this
    /// parameter is
    /// an Amazon Resource Name (ARN). For DataBrew, you can tag a dataset, a job, a
    /// project, or
    /// a recipe.
    resource_arn: []const u8,

    /// One or more tags to be assigned to the resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
