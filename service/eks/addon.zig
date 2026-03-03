const aws = @import("aws");

const AddonHealth = @import("addon_health.zig").AddonHealth;
const MarketplaceInformation = @import("marketplace_information.zig").MarketplaceInformation;
const AddonNamespaceConfigResponse = @import("addon_namespace_config_response.zig").AddonNamespaceConfigResponse;
const AddonStatus = @import("addon_status.zig").AddonStatus;

/// An Amazon EKS add-on. For more information, see [Amazon EKS
/// add-ons](https://docs.aws.amazon.com/eks/latest/userguide/eks-add-ons.html)
/// in the
/// *Amazon EKS User Guide*.
pub const Addon = struct {
    /// The Amazon Resource Name (ARN) of the add-on.
    addon_arn: ?[]const u8 = null,

    /// The name of the add-on.
    addon_name: ?[]const u8 = null,

    /// The version of the add-on.
    addon_version: ?[]const u8 = null,

    /// The name of your cluster.
    cluster_name: ?[]const u8 = null,

    /// The configuration values that you provided.
    configuration_values: ?[]const u8 = null,

    /// The Unix epoch timestamp at object creation.
    created_at: ?i64 = null,

    /// An object that represents the health of the add-on.
    health: ?AddonHealth = null,

    /// Information about an Amazon EKS add-on from the Amazon Web Services
    /// Marketplace.
    marketplace_information: ?MarketplaceInformation = null,

    /// The Unix epoch timestamp for the last modification to the object.
    modified_at: ?i64 = null,

    /// The namespace configuration for the addon. This specifies the Kubernetes
    /// namespace where the addon is installed.
    namespace_config: ?AddonNamespaceConfigResponse = null,

    /// The owner of the add-on.
    owner: ?[]const u8 = null,

    /// An array of EKS Pod Identity associations owned by the add-on. Each
    /// association maps a role to a service
    /// account in a namespace in the cluster.
    ///
    /// For more information, see [Attach an IAM Role to an Amazon EKS add-on
    /// using EKS Pod
    /// Identity](https://docs.aws.amazon.com/eks/latest/userguide/add-ons-iam.html)
    /// in the *Amazon EKS User Guide*.
    pod_identity_associations: ?[]const []const u8 = null,

    /// The publisher of the add-on.
    publisher: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role that's bound to the
    /// Kubernetes `ServiceAccount`
    /// object that the add-on uses.
    service_account_role_arn: ?[]const u8 = null,

    /// The status of the add-on.
    status: ?AddonStatus = null,

    /// Metadata that assists with categorization and organization.
    /// Each tag consists of a key and an optional value. You define both. Tags
    /// don't
    /// propagate to any other cluster or Amazon Web Services resources.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .addon_arn = "addonArn",
        .addon_name = "addonName",
        .addon_version = "addonVersion",
        .cluster_name = "clusterName",
        .configuration_values = "configurationValues",
        .created_at = "createdAt",
        .health = "health",
        .marketplace_information = "marketplaceInformation",
        .modified_at = "modifiedAt",
        .namespace_config = "namespaceConfig",
        .owner = "owner",
        .pod_identity_associations = "podIdentityAssociations",
        .publisher = "publisher",
        .service_account_role_arn = "serviceAccountRoleArn",
        .status = "status",
        .tags = "tags",
    };
};
