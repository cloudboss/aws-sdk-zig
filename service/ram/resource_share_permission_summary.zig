const PermissionFeatureSet = @import("permission_feature_set.zig").PermissionFeatureSet;
const PermissionType = @import("permission_type.zig").PermissionType;
const Tag = @import("tag.zig").Tag;

/// Information about an RAM permission.
pub const ResourceSharePermissionSummary = struct {
    /// The [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the permission you want information about.
    arn: ?[]const u8,

    /// The date and time when the permission was created.
    creation_time: ?i64,

    /// Specifies whether the version of the managed permission used by this
    /// resource share is the default version for
    /// this managed permission.
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

    /// Specifies whether the managed permission associated with this resource share
    /// is the default managed permission for all
    /// resources of this resource type.
    is_resource_type_default: ?bool,

    /// The date and time when the permission was last updated.
    last_updated_time: ?i64,

    /// The name of this managed permission.
    name: ?[]const u8,

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
    permission_type: ?PermissionType,

    /// The type of resource to which this permission applies. This takes the form
    /// of:
    /// `service-code`:`resource-code`, and is case-insensitive. For
    /// example, an Amazon EC2 Subnet would be represented by the string
    /// `ec2:subnet`.
    resource_type: ?[]const u8,

    /// The current status of the permission.
    status: ?[]const u8,

    /// A list of the tag key value pairs currently attached to the permission.
    tags: ?[]const Tag,

    /// The version of the permission associated with this resource share.
    version: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .default_version = "defaultVersion",
        .feature_set = "featureSet",
        .is_resource_type_default = "isResourceTypeDefault",
        .last_updated_time = "lastUpdatedTime",
        .name = "name",
        .permission_type = "permissionType",
        .resource_type = "resourceType",
        .status = "status",
        .tags = "tags",
        .version = "version",
    };
};
