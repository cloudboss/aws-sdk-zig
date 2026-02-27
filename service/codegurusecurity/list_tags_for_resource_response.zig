const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// An array of key-value pairs used to tag an existing scan. A tag is a custom
    /// attribute label with two parts:
    ///
    /// * A tag key. For example, `CostCenter`, `Environment`, or `Secret`. Tag keys
    ///   are case sensitive.
    /// * An optional tag value field. For example, `111122223333`, `Production`, or
    ///   a team name. Omitting the tag value is the same as using an empty string.
    ///   Tag values are case sensitive.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
