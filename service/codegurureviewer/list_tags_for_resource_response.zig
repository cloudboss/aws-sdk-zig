const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// An array of key-value pairs used to tag an associated repository. A tag is a
    /// custom attribute label with two parts:
    ///
    /// * A *tag key* (for example, `CostCenter`,
    /// `Environment`, `Project`, or `Secret`). Tag
    /// keys are case sensitive.
    ///
    /// * An optional field known as a *tag value* (for example,
    /// `111122223333`, `Production`, or a team name).
    /// Omitting the tag value is the same as using an empty string. Like tag keys,
    /// tag
    /// values are case sensitive.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
