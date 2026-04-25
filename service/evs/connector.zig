const ConnectorCheck = @import("connector_check.zig").ConnectorCheck;
const ConnectorState = @import("connector_state.zig").ConnectorState;
const CheckResult = @import("check_result.zig").CheckResult;
const ConnectorType = @import("connector_type.zig").ConnectorType;

/// An object that represents a connector for an Amazon EVS environment. A
/// connector establishes a vCenter connection using the credentials stored in
/// Amazon Web Services Secrets Manager.
pub const Connector = struct {
    /// The fully qualified domain name (FQDN) of the VCF appliance that the
    /// connector connects to.
    appliance_fqdn: ?[]const u8 = null,

    /// A list of checks that are run on the connector.
    checks: ?[]const ConnectorCheck = null,

    /// The unique ID of the connector.
    connector_id: ?[]const u8 = null,

    /// The date and time that the connector was created.
    created_at: ?i64 = null,

    /// The unique ID of the environment that the connector belongs to.
    environment_id: ?[]const u8 = null,

    /// The date and time that the connector was modified.
    modified_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services Secrets Manager
    /// secret that stores the credentials for the VCF appliance.
    secret_arn: ?[]const u8 = null,

    /// The state of the connector.
    state: ?ConnectorState = null,

    /// A detailed description of the connector state.
    state_details: ?[]const u8 = null,

    /// The status of the connector.
    status: ?CheckResult = null,

    /// The type of the connector.
    @"type": ?ConnectorType = null,

    pub const json_field_names = .{
        .appliance_fqdn = "applianceFqdn",
        .checks = "checks",
        .connector_id = "connectorId",
        .created_at = "createdAt",
        .environment_id = "environmentId",
        .modified_at = "modifiedAt",
        .secret_arn = "secretArn",
        .state = "state",
        .state_details = "stateDetails",
        .status = "status",
        .@"type" = "type",
    };
};
