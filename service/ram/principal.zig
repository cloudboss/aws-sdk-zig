/// Describes a principal for use with Resource Access Manager.
pub const Principal = struct {
    /// The date and time when the principal was associated with the resource share.
    creation_time: ?i64 = null,

    /// Indicates the relationship between the Amazon Web Services account the
    /// principal belongs to and the
    /// account that owns the resource share:
    ///
    /// * `True` – The two accounts belong to same
    /// organization.
    ///
    /// * `False` – The two accounts do not belong to the same
    /// organization.
    external: ?bool = null,

    /// The ID of the principal that can be associated with a resource share.
    id: ?[]const u8 = null,

    /// The date and time when the association between the resource share and the
    /// principal
    /// was last updated.
    last_updated_time: ?i64 = null,

    /// The [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of a resource share the principal is associated with.
    resource_share_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .external = "external",
        .id = "id",
        .last_updated_time = "lastUpdatedTime",
        .resource_share_arn = "resourceShareArn",
    };
};
