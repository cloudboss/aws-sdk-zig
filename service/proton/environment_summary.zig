const DeploymentStatus = @import("deployment_status.zig").DeploymentStatus;
const Provisioning = @import("provisioning.zig").Provisioning;

/// Summary data of an Proton environment resource. An Proton environment is a
/// set of resources shared across Proton services.
pub const EnvironmentSummary = struct {
    /// The Amazon Resource Name (ARN) of the environment.
    arn: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM service role that Proton uses when
    /// provisioning directly defined components in this environment. It
    /// determines the scope of infrastructure that a component can provision.
    ///
    /// The environment must have a `componentRoleArn` to allow directly defined
    /// components to be associated with the environment.
    ///
    /// For more information about components, see
    /// [Proton
    /// components](https://docs.aws.amazon.com/proton/latest/userguide/ag-components.html) in the
    /// *Proton User Guide*.
    component_role_arn: ?[]const u8 = null,

    /// The time when the environment was created.
    created_at: i64,

    /// The environment deployment status.
    deployment_status: DeploymentStatus,

    /// An environment deployment status message.
    deployment_status_message: ?[]const u8 = null,

    /// The description of the environment.
    description: ?[]const u8 = null,

    /// The ID of the environment account connection that the environment is
    /// associated with.
    environment_account_connection_id: ?[]const u8 = null,

    /// The ID of the environment account that the environment infrastructure
    /// resources are provisioned in.
    environment_account_id: ?[]const u8 = null,

    /// The ID of the last attempted deployment of this environment.
    last_attempted_deployment_id: ?[]const u8 = null,

    /// The time when a deployment of the environment was last attempted.
    last_deployment_attempted_at: i64,

    /// The time when the environment was last deployed successfully.
    last_deployment_succeeded_at: i64,

    /// The ID of the last successful deployment of this environment.
    last_succeeded_deployment_id: ?[]const u8 = null,

    /// The name of the environment.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the Proton service role that allows Proton
    /// to make calls to other services on your behalf.
    proton_service_role_arn: ?[]const u8 = null,

    /// When included, indicates that the environment template is for customer
    /// provisioned and managed infrastructure.
    provisioning: ?Provisioning = null,

    /// The major version of the environment template.
    template_major_version: []const u8,

    /// The minor version of the environment template.
    template_minor_version: []const u8,

    /// The name of the environment template.
    template_name: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .component_role_arn = "componentRoleArn",
        .created_at = "createdAt",
        .deployment_status = "deploymentStatus",
        .deployment_status_message = "deploymentStatusMessage",
        .description = "description",
        .environment_account_connection_id = "environmentAccountConnectionId",
        .environment_account_id = "environmentAccountId",
        .last_attempted_deployment_id = "lastAttemptedDeploymentId",
        .last_deployment_attempted_at = "lastDeploymentAttemptedAt",
        .last_deployment_succeeded_at = "lastDeploymentSucceededAt",
        .last_succeeded_deployment_id = "lastSucceededDeploymentId",
        .name = "name",
        .proton_service_role_arn = "protonServiceRoleArn",
        .provisioning = "provisioning",
        .template_major_version = "templateMajorVersion",
        .template_minor_version = "templateMinorVersion",
        .template_name = "templateName",
    };
};
