/// A key-value pair containing user-defined metadata that you can associate
/// with an Amazon EMR resource. Tags make it easier to associate clusters in
/// various ways, such as
/// grouping clusters to track your Amazon EMR resource allocation costs. For
/// more
/// information, see [Tag
/// Clusters](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-plan-tags.html).
pub const Tag = struct {
    /// A user-defined key, which is the minimum required information for a valid
    /// tag. For more
    /// information, see
    /// [Tag](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-plan-tags.html).
    key: ?[]const u8,

    /// A user-defined value, which is optional in a tag. For more information, see
    /// [Tag
    /// Clusters](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-plan-tags.html).
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
