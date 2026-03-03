const aws = @import("aws");
const std = @import("std");

const create_account_association = @import("create_account_association.zig");
const create_cloud_connector = @import("create_cloud_connector.zig");
const create_connector_destination = @import("create_connector_destination.zig");
const create_credential_locker = @import("create_credential_locker.zig");
const create_destination = @import("create_destination.zig");
const create_event_log_configuration = @import("create_event_log_configuration.zig");
const create_managed_thing = @import("create_managed_thing.zig");
const create_notification_configuration = @import("create_notification_configuration.zig");
const create_ota_task = @import("create_ota_task.zig");
const create_ota_task_configuration = @import("create_ota_task_configuration.zig");
const create_provisioning_profile = @import("create_provisioning_profile.zig");
const delete_account_association = @import("delete_account_association.zig");
const delete_cloud_connector = @import("delete_cloud_connector.zig");
const delete_connector_destination = @import("delete_connector_destination.zig");
const delete_credential_locker = @import("delete_credential_locker.zig");
const delete_destination = @import("delete_destination.zig");
const delete_event_log_configuration = @import("delete_event_log_configuration.zig");
const delete_managed_thing = @import("delete_managed_thing.zig");
const delete_notification_configuration = @import("delete_notification_configuration.zig");
const delete_ota_task = @import("delete_ota_task.zig");
const delete_ota_task_configuration = @import("delete_ota_task_configuration.zig");
const delete_provisioning_profile = @import("delete_provisioning_profile.zig");
const deregister_account_association = @import("deregister_account_association.zig");
const get_account_association = @import("get_account_association.zig");
const get_cloud_connector = @import("get_cloud_connector.zig");
const get_connector_destination = @import("get_connector_destination.zig");
const get_credential_locker = @import("get_credential_locker.zig");
const get_custom_endpoint = @import("get_custom_endpoint.zig");
const get_default_encryption_configuration = @import("get_default_encryption_configuration.zig");
const get_destination = @import("get_destination.zig");
const get_device_discovery = @import("get_device_discovery.zig");
const get_event_log_configuration = @import("get_event_log_configuration.zig");
const get_hub_configuration = @import("get_hub_configuration.zig");
const get_managed_thing = @import("get_managed_thing.zig");
const get_managed_thing_capabilities = @import("get_managed_thing_capabilities.zig");
const get_managed_thing_certificate = @import("get_managed_thing_certificate.zig");
const get_managed_thing_connectivity_data = @import("get_managed_thing_connectivity_data.zig");
const get_managed_thing_meta_data = @import("get_managed_thing_meta_data.zig");
const get_managed_thing_state = @import("get_managed_thing_state.zig");
const get_notification_configuration = @import("get_notification_configuration.zig");
const get_ota_task = @import("get_ota_task.zig");
const get_ota_task_configuration = @import("get_ota_task_configuration.zig");
const get_provisioning_profile = @import("get_provisioning_profile.zig");
const get_runtime_log_configuration = @import("get_runtime_log_configuration.zig");
const get_schema_version = @import("get_schema_version.zig");
const list_account_associations = @import("list_account_associations.zig");
const list_cloud_connectors = @import("list_cloud_connectors.zig");
const list_connector_destinations = @import("list_connector_destinations.zig");
const list_credential_lockers = @import("list_credential_lockers.zig");
const list_destinations = @import("list_destinations.zig");
const list_device_discoveries = @import("list_device_discoveries.zig");
const list_discovered_devices = @import("list_discovered_devices.zig");
const list_event_log_configurations = @import("list_event_log_configurations.zig");
const list_managed_thing_account_associations = @import("list_managed_thing_account_associations.zig");
const list_managed_thing_schemas = @import("list_managed_thing_schemas.zig");
const list_managed_things = @import("list_managed_things.zig");
const list_notification_configurations = @import("list_notification_configurations.zig");
const list_ota_task_configurations = @import("list_ota_task_configurations.zig");
const list_ota_task_executions = @import("list_ota_task_executions.zig");
const list_ota_tasks = @import("list_ota_tasks.zig");
const list_provisioning_profiles = @import("list_provisioning_profiles.zig");
const list_schema_versions = @import("list_schema_versions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_default_encryption_configuration = @import("put_default_encryption_configuration.zig");
const put_hub_configuration = @import("put_hub_configuration.zig");
const put_runtime_log_configuration = @import("put_runtime_log_configuration.zig");
const register_account_association = @import("register_account_association.zig");
const register_custom_endpoint = @import("register_custom_endpoint.zig");
const reset_runtime_log_configuration = @import("reset_runtime_log_configuration.zig");
const send_connector_event = @import("send_connector_event.zig");
const send_managed_thing_command = @import("send_managed_thing_command.zig");
const start_account_association_refresh = @import("start_account_association_refresh.zig");
const start_device_discovery = @import("start_device_discovery.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_account_association = @import("update_account_association.zig");
const update_cloud_connector = @import("update_cloud_connector.zig");
const update_connector_destination = @import("update_connector_destination.zig");
const update_destination = @import("update_destination.zig");
const update_event_log_configuration = @import("update_event_log_configuration.zig");
const update_managed_thing = @import("update_managed_thing.zig");
const update_notification_configuration = @import("update_notification_configuration.zig");
const update_ota_task = @import("update_ota_task.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "IoT Managed Integrations";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates a new account association via the destination id.
    pub fn createAccountAssociation(self: *Self, allocator: std.mem.Allocator, input: create_account_association.CreateAccountAssociationInput, options: create_account_association.Options) !create_account_association.CreateAccountAssociationOutput {
        return create_account_association.execute(self, allocator, input, options);
    }

    /// Creates a C2C (cloud-to-cloud) connector.
    pub fn createCloudConnector(self: *Self, allocator: std.mem.Allocator, input: create_cloud_connector.CreateCloudConnectorInput, options: create_cloud_connector.Options) !create_cloud_connector.CreateCloudConnectorOutput {
        return create_cloud_connector.execute(self, allocator, input, options);
    }

    /// Create a connector destination for connecting a cloud-to-cloud (C2C)
    /// connector to the customer's Amazon Web Services account.
    pub fn createConnectorDestination(self: *Self, allocator: std.mem.Allocator, input: create_connector_destination.CreateConnectorDestinationInput, options: create_connector_destination.Options) !create_connector_destination.CreateConnectorDestinationOutput {
        return create_connector_destination.execute(self, allocator, input, options);
    }

    /// Create a credential locker.
    ///
    /// This operation will not trigger the creation of all the manufacturing
    /// resources.
    pub fn createCredentialLocker(self: *Self, allocator: std.mem.Allocator, input: create_credential_locker.CreateCredentialLockerInput, options: create_credential_locker.Options) !create_credential_locker.CreateCredentialLockerOutput {
        return create_credential_locker.execute(self, allocator, input, options);
    }

    /// Create a notification destination such as Kinesis Data Streams that receive
    /// events and notifications from Managed integrations. Managed integrations
    /// uses the destination to determine where to deliver notifications.
    pub fn createDestination(self: *Self, allocator: std.mem.Allocator, input: create_destination.CreateDestinationInput, options: create_destination.Options) !create_destination.CreateDestinationOutput {
        return create_destination.execute(self, allocator, input, options);
    }

    /// Set the event log configuration for the account, resource type, or specific
    /// resource.
    pub fn createEventLogConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_event_log_configuration.CreateEventLogConfigurationInput, options: create_event_log_configuration.Options) !create_event_log_configuration.CreateEventLogConfigurationOutput {
        return create_event_log_configuration.execute(self, allocator, input, options);
    }

    /// Creates a managed thing. A managed thing contains the device identifier,
    /// protocol supported, and capabilities of the device in a data model format
    /// defined by Managed integrations.
    pub fn createManagedThing(self: *Self, allocator: std.mem.Allocator, input: create_managed_thing.CreateManagedThingInput, options: create_managed_thing.Options) !create_managed_thing.CreateManagedThingOutput {
        return create_managed_thing.execute(self, allocator, input, options);
    }

    /// Creates a notification configuration. A configuration is a connection
    /// between an event type and a destination that you have already created.
    pub fn createNotificationConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_notification_configuration.CreateNotificationConfigurationInput, options: create_notification_configuration.Options) !create_notification_configuration.CreateNotificationConfigurationOutput {
        return create_notification_configuration.execute(self, allocator, input, options);
    }

    /// Create an over-the-air (OTA) task to target a device.
    pub fn createOtaTask(self: *Self, allocator: std.mem.Allocator, input: create_ota_task.CreateOtaTaskInput, options: create_ota_task.Options) !create_ota_task.CreateOtaTaskOutput {
        return create_ota_task.execute(self, allocator, input, options);
    }

    /// Create a configuraiton for the over-the-air (OTA) task.
    pub fn createOtaTaskConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_ota_task_configuration.CreateOtaTaskConfigurationInput, options: create_ota_task_configuration.Options) !create_ota_task_configuration.CreateOtaTaskConfigurationOutput {
        return create_ota_task_configuration.execute(self, allocator, input, options);
    }

    /// Create a provisioning profile for a device to execute the provisioning flows
    /// using a provisioning template. The provisioning template is a document that
    /// defines the set of resources and policies applied to a device during the
    /// provisioning process.
    pub fn createProvisioningProfile(self: *Self, allocator: std.mem.Allocator, input: create_provisioning_profile.CreateProvisioningProfileInput, options: create_provisioning_profile.Options) !create_provisioning_profile.CreateProvisioningProfileOutput {
        return create_provisioning_profile.execute(self, allocator, input, options);
    }

    /// Remove a third-party account association for an end user.
    ///
    /// You must first call the `DeregisterAccountAssociation` to remove the
    /// connection between the managed thing and the third-party account before
    /// calling the `DeleteAccountAssociation` API.
    pub fn deleteAccountAssociation(self: *Self, allocator: std.mem.Allocator, input: delete_account_association.DeleteAccountAssociationInput, options: delete_account_association.Options) !delete_account_association.DeleteAccountAssociationOutput {
        return delete_account_association.execute(self, allocator, input, options);
    }

    /// Delete a cloud connector.
    pub fn deleteCloudConnector(self: *Self, allocator: std.mem.Allocator, input: delete_cloud_connector.DeleteCloudConnectorInput, options: delete_cloud_connector.Options) !delete_cloud_connector.DeleteCloudConnectorOutput {
        return delete_cloud_connector.execute(self, allocator, input, options);
    }

    /// Delete a connector destination linked to a cloud-to-cloud (C2C) connector.
    ///
    /// Deletion can't be done if the account association has used this connector
    /// destination.
    pub fn deleteConnectorDestination(self: *Self, allocator: std.mem.Allocator, input: delete_connector_destination.DeleteConnectorDestinationInput, options: delete_connector_destination.Options) !delete_connector_destination.DeleteConnectorDestinationOutput {
        return delete_connector_destination.execute(self, allocator, input, options);
    }

    /// Delete a credential locker.
    ///
    /// This operation can't be undone and any existing device won't be able to use
    /// IoT managed integrations.
    pub fn deleteCredentialLocker(self: *Self, allocator: std.mem.Allocator, input: delete_credential_locker.DeleteCredentialLockerInput, options: delete_credential_locker.Options) !delete_credential_locker.DeleteCredentialLockerOutput {
        return delete_credential_locker.execute(self, allocator, input, options);
    }

    /// Deletes a notification destination specified by name.
    pub fn deleteDestination(self: *Self, allocator: std.mem.Allocator, input: delete_destination.DeleteDestinationInput, options: delete_destination.Options) !delete_destination.DeleteDestinationOutput {
        return delete_destination.execute(self, allocator, input, options);
    }

    /// Delete an event log configuration.
    pub fn deleteEventLogConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_event_log_configuration.DeleteEventLogConfigurationInput, options: delete_event_log_configuration.Options) !delete_event_log_configuration.DeleteEventLogConfigurationOutput {
        return delete_event_log_configuration.execute(self, allocator, input, options);
    }

    /// Delete a managed thing. For direct-connected and hub-connected devices
    /// connecting with Managed integrations via a controller, all of the devices
    /// connected to it will have their status changed to `PENDING`. It is not
    /// possible to remove a cloud-to-cloud device.
    pub fn deleteManagedThing(self: *Self, allocator: std.mem.Allocator, input: delete_managed_thing.DeleteManagedThingInput, options: delete_managed_thing.Options) !delete_managed_thing.DeleteManagedThingOutput {
        return delete_managed_thing.execute(self, allocator, input, options);
    }

    /// Deletes a notification configuration.
    pub fn deleteNotificationConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_notification_configuration.DeleteNotificationConfigurationInput, options: delete_notification_configuration.Options) !delete_notification_configuration.DeleteNotificationConfigurationOutput {
        return delete_notification_configuration.execute(self, allocator, input, options);
    }

    /// Delete the over-the-air (OTA) task.
    pub fn deleteOtaTask(self: *Self, allocator: std.mem.Allocator, input: delete_ota_task.DeleteOtaTaskInput, options: delete_ota_task.Options) !delete_ota_task.DeleteOtaTaskOutput {
        return delete_ota_task.execute(self, allocator, input, options);
    }

    /// Delete the over-the-air (OTA) task configuration.
    pub fn deleteOtaTaskConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_ota_task_configuration.DeleteOtaTaskConfigurationInput, options: delete_ota_task_configuration.Options) !delete_ota_task_configuration.DeleteOtaTaskConfigurationOutput {
        return delete_ota_task_configuration.execute(self, allocator, input, options);
    }

    /// Delete a provisioning profile.
    pub fn deleteProvisioningProfile(self: *Self, allocator: std.mem.Allocator, input: delete_provisioning_profile.DeleteProvisioningProfileInput, options: delete_provisioning_profile.Options) !delete_provisioning_profile.DeleteProvisioningProfileOutput {
        return delete_provisioning_profile.execute(self, allocator, input, options);
    }

    /// Deregister an account association from a managed thing.
    pub fn deregisterAccountAssociation(self: *Self, allocator: std.mem.Allocator, input: deregister_account_association.DeregisterAccountAssociationInput, options: deregister_account_association.Options) !deregister_account_association.DeregisterAccountAssociationOutput {
        return deregister_account_association.execute(self, allocator, input, options);
    }

    /// Get an account association for an Amazon Web Services account linked to a
    /// customer-managed destination.
    pub fn getAccountAssociation(self: *Self, allocator: std.mem.Allocator, input: get_account_association.GetAccountAssociationInput, options: get_account_association.Options) !get_account_association.GetAccountAssociationOutput {
        return get_account_association.execute(self, allocator, input, options);
    }

    /// Get configuration details for a cloud connector.
    pub fn getCloudConnector(self: *Self, allocator: std.mem.Allocator, input: get_cloud_connector.GetCloudConnectorInput, options: get_cloud_connector.Options) !get_cloud_connector.GetCloudConnectorOutput {
        return get_cloud_connector.execute(self, allocator, input, options);
    }

    /// Get connector destination details linked to a cloud-to-cloud (C2C)
    /// connector.
    pub fn getConnectorDestination(self: *Self, allocator: std.mem.Allocator, input: get_connector_destination.GetConnectorDestinationInput, options: get_connector_destination.Options) !get_connector_destination.GetConnectorDestinationOutput {
        return get_connector_destination.execute(self, allocator, input, options);
    }

    /// Get information on an existing credential locker
    pub fn getCredentialLocker(self: *Self, allocator: std.mem.Allocator, input: get_credential_locker.GetCredentialLockerInput, options: get_credential_locker.Options) !get_credential_locker.GetCredentialLockerOutput {
        return get_credential_locker.execute(self, allocator, input, options);
    }

    /// Returns the IoT managed integrations custom endpoint.
    pub fn getCustomEndpoint(self: *Self, allocator: std.mem.Allocator, input: get_custom_endpoint.GetCustomEndpointInput, options: get_custom_endpoint.Options) !get_custom_endpoint.GetCustomEndpointOutput {
        return get_custom_endpoint.execute(self, allocator, input, options);
    }

    /// Retrieves information about the default encryption configuration for the
    /// Amazon Web Services account in the default or specified region. For more
    /// information, see [Key
    /// management](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/key-management.html) in the *AWS IoT SiteWise User Guide*.
    pub fn getDefaultEncryptionConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_default_encryption_configuration.GetDefaultEncryptionConfigurationInput, options: get_default_encryption_configuration.Options) !get_default_encryption_configuration.GetDefaultEncryptionConfigurationOutput {
        return get_default_encryption_configuration.execute(self, allocator, input, options);
    }

    /// Gets a destination by name.
    pub fn getDestination(self: *Self, allocator: std.mem.Allocator, input: get_destination.GetDestinationInput, options: get_destination.Options) !get_destination.GetDestinationOutput {
        return get_destination.execute(self, allocator, input, options);
    }

    /// Get the current state of a device discovery.
    pub fn getDeviceDiscovery(self: *Self, allocator: std.mem.Allocator, input: get_device_discovery.GetDeviceDiscoveryInput, options: get_device_discovery.Options) !get_device_discovery.GetDeviceDiscoveryOutput {
        return get_device_discovery.execute(self, allocator, input, options);
    }

    /// Get an event log configuration.
    pub fn getEventLogConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_event_log_configuration.GetEventLogConfigurationInput, options: get_event_log_configuration.Options) !get_event_log_configuration.GetEventLogConfigurationOutput {
        return get_event_log_configuration.execute(self, allocator, input, options);
    }

    /// Get a hub configuration.
    pub fn getHubConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_hub_configuration.GetHubConfigurationInput, options: get_hub_configuration.Options) !get_hub_configuration.GetHubConfigurationOutput {
        return get_hub_configuration.execute(self, allocator, input, options);
    }

    /// Get details of a managed thing including its attributes and capabilities.
    pub fn getManagedThing(self: *Self, allocator: std.mem.Allocator, input: get_managed_thing.GetManagedThingInput, options: get_managed_thing.Options) !get_managed_thing.GetManagedThingOutput {
        return get_managed_thing.execute(self, allocator, input, options);
    }

    /// Get the capabilities for a managed thing using the device ID.
    pub fn getManagedThingCapabilities(self: *Self, allocator: std.mem.Allocator, input: get_managed_thing_capabilities.GetManagedThingCapabilitiesInput, options: get_managed_thing_capabilities.Options) !get_managed_thing_capabilities.GetManagedThingCapabilitiesOutput {
        return get_managed_thing_capabilities.execute(self, allocator, input, options);
    }

    /// Retrieves the certificate PEM for a managed IoT thing.
    pub fn getManagedThingCertificate(self: *Self, allocator: std.mem.Allocator, input: get_managed_thing_certificate.GetManagedThingCertificateInput, options: get_managed_thing_certificate.Options) !get_managed_thing_certificate.GetManagedThingCertificateOutput {
        return get_managed_thing_certificate.execute(self, allocator, input, options);
    }

    /// Get the connectivity status of a managed thing.
    pub fn getManagedThingConnectivityData(self: *Self, allocator: std.mem.Allocator, input: get_managed_thing_connectivity_data.GetManagedThingConnectivityDataInput, options: get_managed_thing_connectivity_data.Options) !get_managed_thing_connectivity_data.GetManagedThingConnectivityDataOutput {
        return get_managed_thing_connectivity_data.execute(self, allocator, input, options);
    }

    /// Get the metadata information for a managed thing.
    ///
    /// The `managedThing` `metadata` parameter is used for associating attributes
    /// with a `managedThing` that can be used for grouping over-the-air (OTA)
    /// tasks. Name value pairs in `metadata` can be used in the
    /// `OtaTargetQueryString` parameter for the `CreateOtaTask` API operation.
    pub fn getManagedThingMetaData(self: *Self, allocator: std.mem.Allocator, input: get_managed_thing_meta_data.GetManagedThingMetaDataInput, options: get_managed_thing_meta_data.Options) !get_managed_thing_meta_data.GetManagedThingMetaDataOutput {
        return get_managed_thing_meta_data.execute(self, allocator, input, options);
    }

    /// Returns the managed thing state for the given device Id.
    pub fn getManagedThingState(self: *Self, allocator: std.mem.Allocator, input: get_managed_thing_state.GetManagedThingStateInput, options: get_managed_thing_state.Options) !get_managed_thing_state.GetManagedThingStateOutput {
        return get_managed_thing_state.execute(self, allocator, input, options);
    }

    /// Get a notification configuration for a specified event type.
    pub fn getNotificationConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_notification_configuration.GetNotificationConfigurationInput, options: get_notification_configuration.Options) !get_notification_configuration.GetNotificationConfigurationOutput {
        return get_notification_configuration.execute(self, allocator, input, options);
    }

    /// Get details of the over-the-air (OTA) task by its task id.
    pub fn getOtaTask(self: *Self, allocator: std.mem.Allocator, input: get_ota_task.GetOtaTaskInput, options: get_ota_task.Options) !get_ota_task.GetOtaTaskOutput {
        return get_ota_task.execute(self, allocator, input, options);
    }

    /// Get a configuraiton for the over-the-air (OTA) task.
    pub fn getOtaTaskConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_ota_task_configuration.GetOtaTaskConfigurationInput, options: get_ota_task_configuration.Options) !get_ota_task_configuration.GetOtaTaskConfigurationOutput {
        return get_ota_task_configuration.execute(self, allocator, input, options);
    }

    /// Get a provisioning profile by template name.
    pub fn getProvisioningProfile(self: *Self, allocator: std.mem.Allocator, input: get_provisioning_profile.GetProvisioningProfileInput, options: get_provisioning_profile.Options) !get_provisioning_profile.GetProvisioningProfileOutput {
        return get_provisioning_profile.execute(self, allocator, input, options);
    }

    /// Get the runtime log configuration for a specific managed thing.
    pub fn getRuntimeLogConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_runtime_log_configuration.GetRuntimeLogConfigurationInput, options: get_runtime_log_configuration.Options) !get_runtime_log_configuration.GetRuntimeLogConfigurationOutput {
        return get_runtime_log_configuration.execute(self, allocator, input, options);
    }

    /// Gets a schema version with the provided information.
    pub fn getSchemaVersion(self: *Self, allocator: std.mem.Allocator, input: get_schema_version.GetSchemaVersionInput, options: get_schema_version.Options) !get_schema_version.GetSchemaVersionOutput {
        return get_schema_version.execute(self, allocator, input, options);
    }

    /// Lists all account associations, with optional filtering by connector
    /// destination ID.
    pub fn listAccountAssociations(self: *Self, allocator: std.mem.Allocator, input: list_account_associations.ListAccountAssociationsInput, options: list_account_associations.Options) !list_account_associations.ListAccountAssociationsOutput {
        return list_account_associations.execute(self, allocator, input, options);
    }

    /// Returns a list of connectors filtered by its Lambda Amazon Resource Name
    /// (ARN) and `type`.
    pub fn listCloudConnectors(self: *Self, allocator: std.mem.Allocator, input: list_cloud_connectors.ListCloudConnectorsInput, options: list_cloud_connectors.Options) !list_cloud_connectors.ListCloudConnectorsOutput {
        return list_cloud_connectors.execute(self, allocator, input, options);
    }

    /// Lists all connector destinations, with optional filtering by cloud connector
    /// ID.
    pub fn listConnectorDestinations(self: *Self, allocator: std.mem.Allocator, input: list_connector_destinations.ListConnectorDestinationsInput, options: list_connector_destinations.Options) !list_connector_destinations.ListConnectorDestinationsOutput {
        return list_connector_destinations.execute(self, allocator, input, options);
    }

    /// List information on an existing credential locker.
    pub fn listCredentialLockers(self: *Self, allocator: std.mem.Allocator, input: list_credential_lockers.ListCredentialLockersInput, options: list_credential_lockers.Options) !list_credential_lockers.ListCredentialLockersOutput {
        return list_credential_lockers.execute(self, allocator, input, options);
    }

    /// List all notification destinations.
    pub fn listDestinations(self: *Self, allocator: std.mem.Allocator, input: list_destinations.ListDestinationsInput, options: list_destinations.Options) !list_destinations.ListDestinationsOutput {
        return list_destinations.execute(self, allocator, input, options);
    }

    /// Lists all device discovery tasks, with optional filtering by type and
    /// status.
    pub fn listDeviceDiscoveries(self: *Self, allocator: std.mem.Allocator, input: list_device_discoveries.ListDeviceDiscoveriesInput, options: list_device_discoveries.Options) !list_device_discoveries.ListDeviceDiscoveriesOutput {
        return list_device_discoveries.execute(self, allocator, input, options);
    }

    /// Lists all devices discovered during a specific device discovery task.
    pub fn listDiscoveredDevices(self: *Self, allocator: std.mem.Allocator, input: list_discovered_devices.ListDiscoveredDevicesInput, options: list_discovered_devices.Options) !list_discovered_devices.ListDiscoveredDevicesOutput {
        return list_discovered_devices.execute(self, allocator, input, options);
    }

    /// List all event log configurations for an account.
    pub fn listEventLogConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_event_log_configurations.ListEventLogConfigurationsInput, options: list_event_log_configurations.Options) !list_event_log_configurations.ListEventLogConfigurationsOutput {
        return list_event_log_configurations.execute(self, allocator, input, options);
    }

    /// Lists all account associations for a specific managed thing.
    pub fn listManagedThingAccountAssociations(self: *Self, allocator: std.mem.Allocator, input: list_managed_thing_account_associations.ListManagedThingAccountAssociationsInput, options: list_managed_thing_account_associations.Options) !list_managed_thing_account_associations.ListManagedThingAccountAssociationsOutput {
        return list_managed_thing_account_associations.execute(self, allocator, input, options);
    }

    /// List schemas associated with a managed thing.
    pub fn listManagedThingSchemas(self: *Self, allocator: std.mem.Allocator, input: list_managed_thing_schemas.ListManagedThingSchemasInput, options: list_managed_thing_schemas.Options) !list_managed_thing_schemas.ListManagedThingSchemasOutput {
        return list_managed_thing_schemas.execute(self, allocator, input, options);
    }

    /// Listing all managed things with provision for filters.
    pub fn listManagedThings(self: *Self, allocator: std.mem.Allocator, input: list_managed_things.ListManagedThingsInput, options: list_managed_things.Options) !list_managed_things.ListManagedThingsOutput {
        return list_managed_things.execute(self, allocator, input, options);
    }

    /// List all notification configurations.
    pub fn listNotificationConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_notification_configurations.ListNotificationConfigurationsInput, options: list_notification_configurations.Options) !list_notification_configurations.ListNotificationConfigurationsOutput {
        return list_notification_configurations.execute(self, allocator, input, options);
    }

    /// List all of the over-the-air (OTA) task configurations.
    pub fn listOtaTaskConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_ota_task_configurations.ListOtaTaskConfigurationsInput, options: list_ota_task_configurations.Options) !list_ota_task_configurations.ListOtaTaskConfigurationsOutput {
        return list_ota_task_configurations.execute(self, allocator, input, options);
    }

    /// List all of the over-the-air (OTA) task executions.
    pub fn listOtaTaskExecutions(self: *Self, allocator: std.mem.Allocator, input: list_ota_task_executions.ListOtaTaskExecutionsInput, options: list_ota_task_executions.Options) !list_ota_task_executions.ListOtaTaskExecutionsOutput {
        return list_ota_task_executions.execute(self, allocator, input, options);
    }

    /// List all of the over-the-air (OTA) tasks.
    pub fn listOtaTasks(self: *Self, allocator: std.mem.Allocator, input: list_ota_tasks.ListOtaTasksInput, options: list_ota_tasks.Options) !list_ota_tasks.ListOtaTasksOutput {
        return list_ota_tasks.execute(self, allocator, input, options);
    }

    /// List the provisioning profiles within the Amazon Web Services account.
    pub fn listProvisioningProfiles(self: *Self, allocator: std.mem.Allocator, input: list_provisioning_profiles.ListProvisioningProfilesInput, options: list_provisioning_profiles.Options) !list_provisioning_profiles.ListProvisioningProfilesOutput {
        return list_provisioning_profiles.execute(self, allocator, input, options);
    }

    /// Lists schema versions with the provided information.
    pub fn listSchemaVersions(self: *Self, allocator: std.mem.Allocator, input: list_schema_versions.ListSchemaVersionsInput, options: list_schema_versions.Options) !list_schema_versions.ListSchemaVersionsOutput {
        return list_schema_versions.execute(self, allocator, input, options);
    }

    /// Lists the tags for a specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Sets the default encryption configuration for the Amazon Web Services
    /// account. For more information, see [Key
    /// management](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/key-management.html) in the AWS IoT SiteWise User Guide.
    pub fn putDefaultEncryptionConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_default_encryption_configuration.PutDefaultEncryptionConfigurationInput, options: put_default_encryption_configuration.Options) !put_default_encryption_configuration.PutDefaultEncryptionConfigurationOutput {
        return put_default_encryption_configuration.execute(self, allocator, input, options);
    }

    /// Update a hub configuration.
    pub fn putHubConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_hub_configuration.PutHubConfigurationInput, options: put_hub_configuration.Options) !put_hub_configuration.PutHubConfigurationOutput {
        return put_hub_configuration.execute(self, allocator, input, options);
    }

    /// Set the runtime log configuration for a specific managed thing.
    pub fn putRuntimeLogConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_runtime_log_configuration.PutRuntimeLogConfigurationInput, options: put_runtime_log_configuration.Options) !put_runtime_log_configuration.PutRuntimeLogConfigurationOutput {
        return put_runtime_log_configuration.execute(self, allocator, input, options);
    }

    /// Registers an account association with a managed thing, establishing a
    /// connection between a device and a third-party account.
    pub fn registerAccountAssociation(self: *Self, allocator: std.mem.Allocator, input: register_account_association.RegisterAccountAssociationInput, options: register_account_association.Options) !register_account_association.RegisterAccountAssociationOutput {
        return register_account_association.execute(self, allocator, input, options);
    }

    /// Customers can request IoT managed integrations to manage the server trust
    /// for them or bring their own external server trusts for the custom domain.
    /// Returns an IoT managed integrations endpoint.
    pub fn registerCustomEndpoint(self: *Self, allocator: std.mem.Allocator, input: register_custom_endpoint.RegisterCustomEndpointInput, options: register_custom_endpoint.Options) !register_custom_endpoint.RegisterCustomEndpointOutput {
        return register_custom_endpoint.execute(self, allocator, input, options);
    }

    /// Reset a runtime log configuration for a specific managed thing.
    pub fn resetRuntimeLogConfiguration(self: *Self, allocator: std.mem.Allocator, input: reset_runtime_log_configuration.ResetRuntimeLogConfigurationInput, options: reset_runtime_log_configuration.Options) !reset_runtime_log_configuration.ResetRuntimeLogConfigurationOutput {
        return reset_runtime_log_configuration.execute(self, allocator, input, options);
    }

    /// Relays third-party device events for a connector such as a new device or a
    /// device state change event.
    pub fn sendConnectorEvent(self: *Self, allocator: std.mem.Allocator, input: send_connector_event.SendConnectorEventInput, options: send_connector_event.Options) !send_connector_event.SendConnectorEventOutput {
        return send_connector_event.execute(self, allocator, input, options);
    }

    /// Send the command to the device represented by the managed thing.
    pub fn sendManagedThingCommand(self: *Self, allocator: std.mem.Allocator, input: send_managed_thing_command.SendManagedThingCommandInput, options: send_managed_thing_command.Options) !send_managed_thing_command.SendManagedThingCommandOutput {
        return send_managed_thing_command.execute(self, allocator, input, options);
    }

    /// Initiates a refresh of an existing account association to update its
    /// authorization and connection status.
    pub fn startAccountAssociationRefresh(self: *Self, allocator: std.mem.Allocator, input: start_account_association_refresh.StartAccountAssociationRefreshInput, options: start_account_association_refresh.Options) !start_account_association_refresh.StartAccountAssociationRefreshOutput {
        return start_account_association_refresh.execute(self, allocator, input, options);
    }

    /// This API is used to start device discovery for hub-connected and
    /// third-party-connected devices. The authentication material (install code) is
    /// delivered as a message to the controller instructing it to start the
    /// discovery.
    pub fn startDeviceDiscovery(self: *Self, allocator: std.mem.Allocator, input: start_device_discovery.StartDeviceDiscoveryInput, options: start_device_discovery.Options) !start_device_discovery.StartDeviceDiscoveryOutput {
        return start_device_discovery.execute(self, allocator, input, options);
    }

    /// Adds tags to a specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from a specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the properties of an existing account association.
    pub fn updateAccountAssociation(self: *Self, allocator: std.mem.Allocator, input: update_account_association.UpdateAccountAssociationInput, options: update_account_association.Options) !update_account_association.UpdateAccountAssociationOutput {
        return update_account_association.execute(self, allocator, input, options);
    }

    /// Update an existing cloud connector.
    pub fn updateCloudConnector(self: *Self, allocator: std.mem.Allocator, input: update_cloud_connector.UpdateCloudConnectorInput, options: update_cloud_connector.Options) !update_cloud_connector.UpdateCloudConnectorOutput {
        return update_cloud_connector.execute(self, allocator, input, options);
    }

    /// Updates the properties of an existing connector destination.
    pub fn updateConnectorDestination(self: *Self, allocator: std.mem.Allocator, input: update_connector_destination.UpdateConnectorDestinationInput, options: update_connector_destination.Options) !update_connector_destination.UpdateConnectorDestinationOutput {
        return update_connector_destination.execute(self, allocator, input, options);
    }

    /// Update a destination specified by name.
    pub fn updateDestination(self: *Self, allocator: std.mem.Allocator, input: update_destination.UpdateDestinationInput, options: update_destination.Options) !update_destination.UpdateDestinationOutput {
        return update_destination.execute(self, allocator, input, options);
    }

    /// Update an event log configuration by log configuration ID.
    pub fn updateEventLogConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_event_log_configuration.UpdateEventLogConfigurationInput, options: update_event_log_configuration.Options) !update_event_log_configuration.UpdateEventLogConfigurationOutput {
        return update_event_log_configuration.execute(self, allocator, input, options);
    }

    /// Update the attributes and capabilities associated with a managed thing.
    pub fn updateManagedThing(self: *Self, allocator: std.mem.Allocator, input: update_managed_thing.UpdateManagedThingInput, options: update_managed_thing.Options) !update_managed_thing.UpdateManagedThingOutput {
        return update_managed_thing.execute(self, allocator, input, options);
    }

    /// Update a notification configuration.
    pub fn updateNotificationConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_notification_configuration.UpdateNotificationConfigurationInput, options: update_notification_configuration.Options) !update_notification_configuration.UpdateNotificationConfigurationOutput {
        return update_notification_configuration.execute(self, allocator, input, options);
    }

    /// Update an over-the-air (OTA) task.
    pub fn updateOtaTask(self: *Self, allocator: std.mem.Allocator, input: update_ota_task.UpdateOtaTaskInput, options: update_ota_task.Options) !update_ota_task.UpdateOtaTaskOutput {
        return update_ota_task.execute(self, allocator, input, options);
    }

    pub fn listAccountAssociationsPaginator(self: *Self, params: list_account_associations.ListAccountAssociationsInput) paginator.ListAccountAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCloudConnectorsPaginator(self: *Self, params: list_cloud_connectors.ListCloudConnectorsInput) paginator.ListCloudConnectorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listConnectorDestinationsPaginator(self: *Self, params: list_connector_destinations.ListConnectorDestinationsInput) paginator.ListConnectorDestinationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCredentialLockersPaginator(self: *Self, params: list_credential_lockers.ListCredentialLockersInput) paginator.ListCredentialLockersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDestinationsPaginator(self: *Self, params: list_destinations.ListDestinationsInput) paginator.ListDestinationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDeviceDiscoveriesPaginator(self: *Self, params: list_device_discoveries.ListDeviceDiscoveriesInput) paginator.ListDeviceDiscoveriesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDiscoveredDevicesPaginator(self: *Self, params: list_discovered_devices.ListDiscoveredDevicesInput) paginator.ListDiscoveredDevicesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEventLogConfigurationsPaginator(self: *Self, params: list_event_log_configurations.ListEventLogConfigurationsInput) paginator.ListEventLogConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listManagedThingAccountAssociationsPaginator(self: *Self, params: list_managed_thing_account_associations.ListManagedThingAccountAssociationsInput) paginator.ListManagedThingAccountAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listManagedThingSchemasPaginator(self: *Self, params: list_managed_thing_schemas.ListManagedThingSchemasInput) paginator.ListManagedThingSchemasPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listManagedThingsPaginator(self: *Self, params: list_managed_things.ListManagedThingsInput) paginator.ListManagedThingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listNotificationConfigurationsPaginator(self: *Self, params: list_notification_configurations.ListNotificationConfigurationsInput) paginator.ListNotificationConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listOtaTaskConfigurationsPaginator(self: *Self, params: list_ota_task_configurations.ListOtaTaskConfigurationsInput) paginator.ListOtaTaskConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listOtaTaskExecutionsPaginator(self: *Self, params: list_ota_task_executions.ListOtaTaskExecutionsInput) paginator.ListOtaTaskExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listOtaTasksPaginator(self: *Self, params: list_ota_tasks.ListOtaTasksInput) paginator.ListOtaTasksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listProvisioningProfilesPaginator(self: *Self, params: list_provisioning_profiles.ListProvisioningProfilesInput) paginator.ListProvisioningProfilesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSchemaVersionsPaginator(self: *Self, params: list_schema_versions.ListSchemaVersionsInput) paginator.ListSchemaVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
