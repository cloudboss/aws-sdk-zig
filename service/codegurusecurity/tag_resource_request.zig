const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The ARN of the `ScanName` object. You can retrieve this ARN by calling
    /// `CreateScan`, `ListScans`, or `GetScan`.
    resource_arn: []const u8,

    /// An array of key-value pairs used to tag an existing scan. A tag is a custom
    /// attribute label with two parts:
    ///
    /// * A tag key. For example, `CostCenter`, `Environment`, or `Secret`. Tag keys
    ///   are case sensitive.
    /// * An optional tag value field. For example, `111122223333`, `Production`, or
    ///   a team name. Omitting the tag value is the same as using an empty string.
    ///   Tag values are case sensitive.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
