const PermissionFeatureSet = @import("permission_feature_set.zig").PermissionFeatureSet;

/// An object that describes a managed permission associated with a resource
/// share.
pub const AssociatedPermission = struct {
    /// The [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the associated managed permission.
    arn: ?[]const u8,

    /// Indicates whether the associated resource share is using the default version
    /// of the
    /// permission.
    default_version: ?bool,

    /// Indicates what features are available for this resource share. This
    /// parameter can have one of
    /// the following values:
    ///
    /// * **STANDARD** – A resource share that supports all
    /// functionality. These resource shares are visible to all principals you share
    /// the resource share with.
    /// You can modify these resource shares in RAM using the console or APIs. This
    /// resource share might
    /// have been created by RAM, or it might have been **CREATED_FROM_POLICY** and
    /// then promoted.
    ///
    /// * **CREATED_FROM_POLICY** – The customer
    /// manually shared a resource by attaching a resource-based policy. That policy
    /// did
    /// not match any existing managed permissions, so RAM created this customer
    /// managed permission automatically on the
    /// customer's behalf based on the attached policy document. This type of
    /// resource share
    /// is visible only to the Amazon Web Services account that created it. You
    /// can't modify it in
    /// RAM unless you promote it. For more information,
    /// see PromoteResourceShareCreatedFromPolicy.
    ///
    /// * **PROMOTING_TO_STANDARD** – This
    /// resource share was originally `CREATED_FROM_POLICY`, but the customer ran
    /// the PromoteResourceShareCreatedFromPolicy and that operation
    /// is still in progress. This value changes to `STANDARD` when
    /// complete.
    feature_set: ?PermissionFeatureSet,

    /// The date and time when the association between the permission and the
    /// resource share
    /// was last updated.
    last_updated_time: ?i64,

    /// The version of the permission currently associated with the resource share.
    permission_version: ?[]const u8,

    /// The [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of a resource share associated with this permission.
    resource_share_arn: ?[]const u8,

    /// The resource type to which this permission applies.
    resource_type: ?[]const u8,

    /// The current status of the association between the permission and the
    /// resource share.
    /// The following are the possible values:
    ///
    /// * `ATTACHABLE` – This permission or version can be associated
    /// with resource shares.
    ///
    /// * `UNATTACHABLE` – This permission or version can't
    /// currently be associated with resource shares.
    ///
    /// * `DELETING` – This permission or version is in the process of
    /// being deleted.
    ///
    /// * `DELETED` – This permission or version is deleted.
    status: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .default_version = "defaultVersion",
        .feature_set = "featureSet",
        .last_updated_time = "lastUpdatedTime",
        .permission_version = "permissionVersion",
        .resource_share_arn = "resourceShareArn",
        .resource_type = "resourceType",
        .status = "status",
    };
};
