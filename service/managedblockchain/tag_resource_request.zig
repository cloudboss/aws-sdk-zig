const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource. For more information about
    /// ARNs and their format, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon Web Services General Reference*.
    resource_arn: []const u8,

    /// The tags to assign to the specified resource. Tag values can be empty, for
    /// example, `"MyTagKey" : ""`. You can specify multiple key-value pairs in a
    /// single request, with an overall maximum of 50 tags added to each resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
