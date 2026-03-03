const ResourceShareAssociationType = @import("resource_share_association_type.zig").ResourceShareAssociationType;
const ResourceShareAssociationStatus = @import("resource_share_association_status.zig").ResourceShareAssociationStatus;

/// Describes an association between a resource share and either a principal or
/// a resource.
pub const ResourceShareAssociation = struct {
    /// The associated entity. This can be either of the following:
    ///
    /// * For a resource association, this is the [Amazon Resource Name
    ///   (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the resource.
    ///
    /// * For principal associations, this is one of the following:
    ///
    /// * The ID of an Amazon Web Services account
    ///
    /// * The [Amazon Resource Name
    ///   (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of an organization in Organizations
    ///
    /// * The ARN of an organizational unit (OU) in Organizations
    ///
    /// * The ARN of an IAM role
    ///
    /// * The ARN of an IAM user
    associated_entity: ?[]const u8 = null,

    /// The type of entity included in this association.
    association_type: ?ResourceShareAssociationType = null,

    /// The date and time when the association was created.
    creation_time: ?i64 = null,

    /// Indicates whether the principal belongs to the same organization in
    /// Organizations as the
    /// Amazon Web Services account that owns the resource share.
    external: ?bool = null,

    /// The date and time when the association was last updated.
    last_updated_time: ?i64 = null,

    /// The [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the resource share.
    resource_share_arn: ?[]const u8 = null,

    /// The name of the resource share.
    resource_share_name: ?[]const u8 = null,

    /// The current status of the association.
    status: ?ResourceShareAssociationStatus = null,

    /// A message about the status of the association.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .associated_entity = "associatedEntity",
        .association_type = "associationType",
        .creation_time = "creationTime",
        .external = "external",
        .last_updated_time = "lastUpdatedTime",
        .resource_share_arn = "resourceShareArn",
        .resource_share_name = "resourceShareName",
        .status = "status",
        .status_message = "statusMessage",
    };
};
