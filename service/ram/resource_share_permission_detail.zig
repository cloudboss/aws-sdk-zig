const PermissionFeatureSet = @import("permission_feature_set.zig").PermissionFeatureSet;
const PermissionType = @import("permission_type.zig").PermissionType;
const PermissionStatus = @import("permission_status.zig").PermissionStatus;
const Tag = @import("tag.zig").Tag;

/// Information about a RAM managed permission.
pub const ResourceSharePermissionDetail = struct {
    /// The [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of this RAM managed permission.
    arn: ?[]const u8 = null,

    /// The date and time when the permission was created.
    creation_time: ?i64 = null,

    /// Specifies whether the version of the permission represented in this response
    /// is the
    /// default version for this permission.
    default_version: ?bool = null,

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
    feature_set: ?PermissionFeatureSet = null,

    /// Specifies whether the version of the permission represented in this response
    /// is the
    /// default version for all resources of this resource type.
    is_resource_type_default: ?bool = null,

    /// The date and time when the permission was last updated.
    last_updated_time: ?i64 = null,

    /// The name of this permission.
    name: ?[]const u8 = null,

    /// The permission's effect and actions in JSON format. The `effect` indicates
    /// whether the specified actions are allowed or denied. The `actions` list the
    /// operations to which the principal is granted or denied access.
    permission: ?[]const u8 = null,

    /// The type of managed permission. This can be one of the following values:
    ///
    /// * `AWS_MANAGED` – Amazon Web Services created and manages this
    /// managed permission. You can associate it with your resource shares, but you
    /// can't modify it.
    ///
    /// * `CUSTOMER_MANAGED` – You, or another principal in
    /// your account created this managed permission. You can associate it with your
    /// resource shares and create
    /// new versions that have different permissions.
    permission_type: ?PermissionType = null,

    /// The resource type to which this permission applies.
    resource_type: ?[]const u8 = null,

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
    status: ?PermissionStatus = null,

    /// The tag key and value pairs attached to the resource share.
    tags: ?[]const Tag = null,

    /// The version of the permission described in this response.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .default_version = "defaultVersion",
        .feature_set = "featureSet",
        .is_resource_type_default = "isResourceTypeDefault",
        .last_updated_time = "lastUpdatedTime",
        .name = "name",
        .permission = "permission",
        .permission_type = "permissionType",
        .resource_type = "resourceType",
        .status = "status",
        .tags = "tags",
        .version = "version",
    };
};
