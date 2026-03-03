const aws = @import("aws");

const AccountAccessType = @import("account_access_type.zig").AccountAccessType;
const AuthenticationSummary = @import("authentication_summary.zig").AuthenticationSummary;
const DataSourceType = @import("data_source_type.zig").DataSourceType;
const LicenseType = @import("license_type.zig").LicenseType;
const NetworkAccessConfiguration = @import("network_access_configuration.zig").NetworkAccessConfiguration;
const NotificationDestinationType = @import("notification_destination_type.zig").NotificationDestinationType;
const PermissionType = @import("permission_type.zig").PermissionType;
const WorkspaceStatus = @import("workspace_status.zig").WorkspaceStatus;
const VpcConfiguration = @import("vpc_configuration.zig").VpcConfiguration;

/// A structure containing information about an Amazon Managed Grafana workspace
/// in your
/// account.
pub const WorkspaceDescription = struct {
    /// Specifies whether the workspace can access Amazon Web Services resources in
    /// this
    /// Amazon Web Services account only, or whether it can also access Amazon Web
    /// Services
    /// resources in other accounts in the same organization. If this is
    /// `ORGANIZATION`, the `workspaceOrganizationalUnits` parameter
    /// specifies which organizational units the workspace can access.
    account_access_type: ?AccountAccessType = null,

    /// A structure that describes whether the workspace uses SAML, IAM Identity
    /// Center, or
    /// both methods for user authentication.
    authentication: AuthenticationSummary,

    /// The date that the workspace was created.
    created: i64,

    /// Specifies the Amazon Web Services data sources that have been configured to
    /// have
    /// IAM roles and permissions created to allow Amazon Managed Grafana to read
    /// data from these sources.
    ///
    /// This list is only used when the workspace was created through the Amazon Web
    /// Services
    /// console, and the `permissionType` is `SERVICE_MANAGED`.
    data_sources: []const DataSourceType,

    /// The user-defined description of the workspace.
    description: ?[]const u8 = null,

    /// The URL that users can use to access the Grafana console in the workspace.
    endpoint: []const u8,

    /// Specifies whether this workspace has already fully used its free trial for
    /// Grafana
    /// Enterprise.
    ///
    /// Amazon Managed Grafana workspaces no longer support Grafana Enterprise free
    /// trials.
    free_trial_consumed: ?bool = null,

    /// If this workspace is currently in the free trial period for Grafana
    /// Enterprise, this
    /// value specifies when that free trial ends.
    ///
    /// Amazon Managed Grafana workspaces no longer support Grafana Enterprise free
    /// trials.
    free_trial_expiration: ?i64 = null,

    /// The token that ties this workspace to a Grafana Labs account. For more
    /// information,
    /// see [Link your account with Grafana
    /// Labs](https://docs.aws.amazon.com/grafana/latest/userguide/upgrade-to-Grafana-Enterprise.html#AMG-workspace-register-enterprise).
    grafana_token: ?[]const u8 = null,

    /// The version of Grafana supported in this workspace.
    grafana_version: []const u8,

    /// The unique ID of this workspace.
    id: []const u8,

    /// If this workspace has a full Grafana Enterprise license purchased through
    /// Amazon Web Services Marketplace, this specifies when the
    /// license ends and will need to be renewed. Purchasing the Enterprise plugins
    /// option
    /// through Amazon Managed Grafana does not have an expiration. It is valid
    /// until the
    /// license is removed.
    license_expiration: ?i64 = null,

    /// Specifies whether this workspace has a full Grafana Enterprise license.
    ///
    /// Amazon Managed Grafana workspaces no longer support Grafana Enterprise free
    /// trials.
    license_type: ?LicenseType = null,

    /// The most recent date that the workspace was modified.
    modified: i64,

    /// The name of the workspace.
    name: ?[]const u8 = null,

    /// The configuration settings for network access to your workspace.
    network_access_control: ?NetworkAccessConfiguration = null,

    /// The Amazon Web Services notification channels that Amazon Managed Grafana
    /// can automatically
    /// create IAM roles and permissions for, to allow Amazon Managed Grafana to use
    /// these channels.
    notification_destinations: ?[]const NotificationDestinationType = null,

    /// Specifies the organizational units that this workspace is allowed to use
    /// data sources
    /// from, if this workspace is in an account that is part of an organization.
    organizational_units: ?[]const []const u8 = null,

    /// The name of the IAM role that is used to access resources through
    /// Organizations.
    organization_role_name: ?[]const u8 = null,

    /// If this is `SERVICE_MANAGED`, and the workplace was created through the
    /// Amazon Managed Grafana console, then Amazon Managed Grafana automatically
    /// creates the
    /// IAM roles and provisions the permissions that the workspace needs to
    /// use Amazon Web Services data sources and notification channels.
    ///
    /// If this is `CUSTOMER_MANAGED`, you must manage those roles and permissions
    /// yourself.
    ///
    /// If you are working with a workspace in a member account of an organization
    /// and
    /// that account is not a delegated administrator account, and you want the
    /// workspace to
    /// access data sources in other Amazon Web Services accounts in the
    /// organization, this
    /// parameter must be set to `CUSTOMER_MANAGED`.
    ///
    /// For more information about converting between customer and service managed,
    /// see
    /// [Managing permissions for data sources and notification
    /// channels](https://docs.aws.amazon.com/grafana/latest/userguide/AMG-datasource-and-notification.html). For more
    /// information about the roles and permissions that must be managed for
    /// customer managed
    /// workspaces, see [Amazon Managed Grafana
    /// permissions and policies for Amazon Web Services data sources and
    /// notification
    /// channels](https://docs.aws.amazon.com/grafana/latest/userguide/AMG-manage-permissions.html)
    permission_type: ?PermissionType = null,

    /// The name of the CloudFormation stack set that is used to generate IAM roles
    /// to be used for this workspace.
    stack_set_name: ?[]const u8 = null,

    /// The current status of the workspace.
    status: WorkspaceStatus,

    /// The list of tags associated with the workspace.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The configuration for connecting to data sources in a private VPC (Amazon
    /// Virtual Private Cloud).
    vpc_configuration: ?VpcConfiguration = null,

    /// The IAM role that grants permissions to the Amazon Web Services
    /// resources that the workspace will view data from. This role must already
    /// exist.
    workspace_role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_access_type = "accountAccessType",
        .authentication = "authentication",
        .created = "created",
        .data_sources = "dataSources",
        .description = "description",
        .endpoint = "endpoint",
        .free_trial_consumed = "freeTrialConsumed",
        .free_trial_expiration = "freeTrialExpiration",
        .grafana_token = "grafanaToken",
        .grafana_version = "grafanaVersion",
        .id = "id",
        .license_expiration = "licenseExpiration",
        .license_type = "licenseType",
        .modified = "modified",
        .name = "name",
        .network_access_control = "networkAccessControl",
        .notification_destinations = "notificationDestinations",
        .organizational_units = "organizationalUnits",
        .organization_role_name = "organizationRoleName",
        .permission_type = "permissionType",
        .stack_set_name = "stackSetName",
        .status = "status",
        .tags = "tags",
        .vpc_configuration = "vpcConfiguration",
        .workspace_role_arn = "workspaceRoleArn",
    };
};
