const aws = @import("aws");

const AuthenticationSummary = @import("authentication_summary.zig").AuthenticationSummary;
const LicenseType = @import("license_type.zig").LicenseType;
const NotificationDestinationType = @import("notification_destination_type.zig").NotificationDestinationType;
const WorkspaceStatus = @import("workspace_status.zig").WorkspaceStatus;

/// A structure that contains some information about one workspace in the
/// account.
pub const WorkspaceSummary = struct {
    /// A structure containing information about the authentication methods used in
    /// the
    /// workspace.
    authentication: AuthenticationSummary,

    /// The date that the workspace was created.
    created: i64,

    /// The customer-entered description of the workspace.
    description: ?[]const u8 = null,

    /// The URL endpoint to use to access the Grafana console in the workspace.
    endpoint: []const u8,

    /// The token that ties this workspace to a Grafana Labs account. For more
    /// information,
    /// see [Link your account with Grafana
    /// Labs](https://docs.aws.amazon.com/grafana/latest/userguide/upgrade-to-Grafana-Enterprise.html#AMG-workspace-register-enterprise).
    grafana_token: ?[]const u8 = null,

    /// The Grafana version that the workspace is running.
    grafana_version: []const u8,

    /// The unique ID of the workspace.
    id: []const u8,

    /// Specifies whether this workspace has a full Grafana Enterprise license.
    ///
    /// Amazon Managed Grafana workspaces no longer support Grafana Enterprise free
    /// trials.
    license_type: ?LicenseType = null,

    /// The most recent date that the workspace was modified.
    modified: i64,

    /// The name of the workspace.
    name: ?[]const u8 = null,

    /// The Amazon Web Services notification channels that Amazon Managed Grafana
    /// can automatically
    /// create IAM roles and permissions for, which allows Amazon Managed Grafana to
    /// use these channels.
    notification_destinations: ?[]const NotificationDestinationType = null,

    /// The current status of the workspace.
    status: WorkspaceStatus,

    /// The list of tags associated with the workspace.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .authentication = "authentication",
        .created = "created",
        .description = "description",
        .endpoint = "endpoint",
        .grafana_token = "grafanaToken",
        .grafana_version = "grafanaVersion",
        .id = "id",
        .license_type = "licenseType",
        .modified = "modified",
        .name = "name",
        .notification_destinations = "notificationDestinations",
        .status = "status",
        .tags = "tags",
    };
};
