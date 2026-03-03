const ProvisioningStatus = @import("provisioning_status.zig").ProvisioningStatus;
const Role = @import("role.zig").Role;

/// Structure representing one managed thing.
pub const ManagedThingSummary = struct {
    /// The timestampe value of when the managed thing was activated at.
    activated_at: ?i64 = null,

    /// The id of the advertised product.
    advertised_product_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the managed thing.
    arn: ?[]const u8 = null,

    /// The brand of the device.
    brand: ?[]const u8 = null,

    /// The classification of the managed thing such as light bulb or thermostat.
    classification: ?[]const u8 = null,

    /// The identifier of the connector destination associated with this managed
    /// thing, if applicable.
    connector_destination_id: ?[]const u8 = null,

    /// The third-party device id as defined by the connector. This device id must
    /// not contain personal identifiable information (PII).
    ///
    /// This parameter is used for cloud-to-cloud devices only.
    connector_device_id: ?[]const u8 = null,

    /// The id of the connector policy.
    ///
    /// This parameter is used for cloud-to-cloud devices only.
    connector_policy_id: ?[]const u8 = null,

    /// The timestamp value of when the device creation request occurred.
    created_at: ?i64 = null,

    /// The identifier of the credential locker for the managed thing.
    credential_locker_id: ?[]const u8 = null,

    /// The id of the device.
    id: ?[]const u8 = null,

    /// The model of the device.
    model: ?[]const u8 = null,

    /// The name of the managed thing representing the physical device.
    name: ?[]const u8 = null,

    /// Owner of the device, usually an indication of whom the device belongs to.
    /// This value should not contain personal identifiable information.
    owner: ?[]const u8 = null,

    /// Id of the controller device used for the discovery job.
    parent_controller_id: ?[]const u8 = null,

    /// The provisioning status of the device in the provisioning workflow for
    /// onboarding to IoT managed integrations. For more information, see [Device
    /// Provisioning](https://docs.aws.amazon.com/iot-mi/latest/devguide/device-provisioning.html).
    provisioning_status: ?ProvisioningStatus = null,

    /// The type of device used. This will be the Amazon Web Services hub
    /// controller, cloud device, or IoT device.
    role: ?Role = null,

    /// The serial number of the device.
    serial_number: ?[]const u8 = null,

    /// The timestamp value of when the managed thing was last updated at.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .activated_at = "ActivatedAt",
        .advertised_product_id = "AdvertisedProductId",
        .arn = "Arn",
        .brand = "Brand",
        .classification = "Classification",
        .connector_destination_id = "ConnectorDestinationId",
        .connector_device_id = "ConnectorDeviceId",
        .connector_policy_id = "ConnectorPolicyId",
        .created_at = "CreatedAt",
        .credential_locker_id = "CredentialLockerId",
        .id = "Id",
        .model = "Model",
        .name = "Name",
        .owner = "Owner",
        .parent_controller_id = "ParentControllerId",
        .provisioning_status = "ProvisioningStatus",
        .role = "Role",
        .serial_number = "SerialNumber",
        .updated_at = "UpdatedAt",
    };
};
