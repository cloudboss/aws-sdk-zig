const ResourceShareFeatureSet = @import("resource_share_feature_set.zig").ResourceShareFeatureSet;
const ResourceShareConfiguration = @import("resource_share_configuration.zig").ResourceShareConfiguration;
const ResourceShareStatus = @import("resource_share_status.zig").ResourceShareStatus;
const Tag = @import("tag.zig").Tag;

/// Describes a resource share in RAM.
pub const ResourceShare = struct {
    /// Indicates whether principals outside your organization in Organizations can
    /// be associated
    /// with a resource share.
    ///
    /// * `True` – the resource share can be shared with any
    /// Amazon Web Services account.
    ///
    /// * `False` – the resource share can be shared with only
    /// accounts in the same organization as the account that owns the resource
    /// share.
    allow_external_principals: ?bool = null,

    /// The date and time when the resource share was created.
    creation_time: ?i64 = null,

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
    feature_set: ?ResourceShareFeatureSet = null,

    /// The date and time when the resource share was last updated.
    last_updated_time: ?i64 = null,

    /// The name of the resource share.
    name: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that owns the resource share.
    owning_account_id: ?[]const u8 = null,

    /// The [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the resource share
    resource_share_arn: ?[]const u8 = null,

    /// The configuration of the resource share
    resource_share_configuration: ?ResourceShareConfiguration = null,

    /// The current status of the resource share.
    status: ?ResourceShareStatus = null,

    /// A message about the status of the resource share.
    status_message: ?[]const u8 = null,

    /// The tag key and value pairs attached to the resource share.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .allow_external_principals = "allowExternalPrincipals",
        .creation_time = "creationTime",
        .feature_set = "featureSet",
        .last_updated_time = "lastUpdatedTime",
        .name = "name",
        .owning_account_id = "owningAccountId",
        .resource_share_arn = "resourceShareArn",
        .resource_share_configuration = "resourceShareConfiguration",
        .status = "status",
        .status_message = "statusMessage",
        .tags = "tags",
    };
};
