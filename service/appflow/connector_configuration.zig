const AuthenticationConfig = @import("authentication_config.zig").AuthenticationConfig;
const ConnectorMetadata = @import("connector_metadata.zig").ConnectorMetadata;
const ConnectorProvisioningConfig = @import("connector_provisioning_config.zig").ConnectorProvisioningConfig;
const ConnectorProvisioningType = @import("connector_provisioning_type.zig").ConnectorProvisioningType;
const ConnectorRuntimeSetting = @import("connector_runtime_setting.zig").ConnectorRuntimeSetting;
const ConnectorType = @import("connector_type.zig").ConnectorType;
const DataTransferApi = @import("data_transfer_api.zig").DataTransferApi;
const SupportedDataTransferType = @import("supported_data_transfer_type.zig").SupportedDataTransferType;
const Operators = @import("operators.zig").Operators;
const ScheduleFrequencyType = @import("schedule_frequency_type.zig").ScheduleFrequencyType;
const TriggerType = @import("trigger_type.zig").TriggerType;
const WriteOperationType = @import("write_operation_type.zig").WriteOperationType;

/// The configuration settings related to a given connector.
pub const ConnectorConfiguration = struct {
    /// The authentication config required for the connector.
    authentication_config: ?AuthenticationConfig = null,

    /// Specifies whether the connector can be used as a destination.
    can_use_as_destination: bool = false,

    /// Specifies whether the connector can be used as a source.
    can_use_as_source: bool = false,

    /// The Amazon Resource Name (ARN) for the registered connector.
    connector_arn: ?[]const u8 = null,

    /// A description about the connector.
    connector_description: ?[]const u8 = null,

    /// The label used for registering the connector.
    connector_label: ?[]const u8 = null,

    /// Specifies connector-specific metadata such as `oAuthScopes`,
    /// `supportedRegions`, `privateLinkServiceUrl`, and so on.
    connector_metadata: ?ConnectorMetadata = null,

    /// The connection modes that the connector supports.
    connector_modes: ?[]const []const u8 = null,

    /// The connector name.
    connector_name: ?[]const u8 = null,

    /// The owner who developed the connector.
    connector_owner: ?[]const u8 = null,

    /// The configuration required for registering the connector.
    connector_provisioning_config: ?ConnectorProvisioningConfig = null,

    /// The provisioning type used to register the connector.
    connector_provisioning_type: ?ConnectorProvisioningType = null,

    /// The required connector runtime settings.
    connector_runtime_settings: ?[]const ConnectorRuntimeSetting = null,

    /// The connector type.
    connector_type: ?ConnectorType = null,

    /// The connector version.
    connector_version: ?[]const u8 = null,

    /// Specifies if PrivateLink is enabled for that connector.
    is_private_link_enabled: bool = false,

    /// Specifies if a PrivateLink endpoint URL is required.
    is_private_link_endpoint_url_required: bool = false,

    /// Logo URL of the connector.
    logo_url: ?[]const u8 = null,

    /// The date on which the connector was registered.
    registered_at: ?i64 = null,

    /// Information about who registered the connector.
    registered_by: ?[]const u8 = null,

    /// A list of API versions that are supported by the connector.
    supported_api_versions: ?[]const []const u8 = null,

    /// The APIs of the connector application that Amazon AppFlow can use to
    /// transfer your
    /// data.
    supported_data_transfer_apis: ?[]const DataTransferApi = null,

    /// The data transfer types that the connector supports.
    ///
    /// **RECORD**
    ///
    /// Structured records.
    ///
    /// **FILE**
    ///
    /// Files or binary data.
    supported_data_transfer_types: ?[]const SupportedDataTransferType = null,

    /// Lists the connectors that are available for use as destinations.
    supported_destination_connectors: ?[]const ConnectorType = null,

    /// A list of operators supported by the connector.
    supported_operators: ?[]const Operators = null,

    /// Specifies the supported flow frequency for that connector.
    supported_scheduling_frequencies: ?[]const ScheduleFrequencyType = null,

    /// Specifies the supported trigger types for the flow.
    supported_trigger_types: ?[]const TriggerType = null,

    /// A list of write operations supported by the connector.
    supported_write_operations: ?[]const WriteOperationType = null,

    pub const json_field_names = .{
        .authentication_config = "authenticationConfig",
        .can_use_as_destination = "canUseAsDestination",
        .can_use_as_source = "canUseAsSource",
        .connector_arn = "connectorArn",
        .connector_description = "connectorDescription",
        .connector_label = "connectorLabel",
        .connector_metadata = "connectorMetadata",
        .connector_modes = "connectorModes",
        .connector_name = "connectorName",
        .connector_owner = "connectorOwner",
        .connector_provisioning_config = "connectorProvisioningConfig",
        .connector_provisioning_type = "connectorProvisioningType",
        .connector_runtime_settings = "connectorRuntimeSettings",
        .connector_type = "connectorType",
        .connector_version = "connectorVersion",
        .is_private_link_enabled = "isPrivateLinkEnabled",
        .is_private_link_endpoint_url_required = "isPrivateLinkEndpointUrlRequired",
        .logo_url = "logoURL",
        .registered_at = "registeredAt",
        .registered_by = "registeredBy",
        .supported_api_versions = "supportedApiVersions",
        .supported_data_transfer_apis = "supportedDataTransferApis",
        .supported_data_transfer_types = "supportedDataTransferTypes",
        .supported_destination_connectors = "supportedDestinationConnectors",
        .supported_operators = "supportedOperators",
        .supported_scheduling_frequencies = "supportedSchedulingFrequencies",
        .supported_trigger_types = "supportedTriggerTypes",
        .supported_write_operations = "supportedWriteOperations",
    };
};
