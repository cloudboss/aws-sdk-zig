const aws = @import("aws");

const DeviceBrand = @import("device_brand.zig").DeviceBrand;
const DeviceAggregatedStatus = @import("device_aggregated_status.zig").DeviceAggregatedStatus;
const LatestDeviceJob = @import("latest_device_job.zig").LatestDeviceJob;
const DeviceStatus = @import("device_status.zig").DeviceStatus;
const DeviceType = @import("device_type.zig").DeviceType;

/// A device.
pub const Device = struct {
    /// The device's maker.
    brand: ?DeviceBrand,

    /// When the device was created.
    created_time: ?i64,

    /// A device's current software.
    current_software: ?[]const u8,

    /// A description for the device.
    description: ?[]const u8,

    /// A device's aggregated status. Including the device's connection status,
    /// provisioning status, and lease status.
    device_aggregated_status: ?DeviceAggregatedStatus,

    /// The device's ID.
    device_id: ?[]const u8,

    /// When the device was updated.
    last_updated_time: ?i64,

    /// A device's latest job. Includes the target image version, and the update job
    /// status.
    latest_device_job: ?LatestDeviceJob,

    /// The device's lease expiration time.
    lease_expiration_time: ?i64,

    /// The device's name.
    name: ?[]const u8,

    /// The device's provisioning status.
    provisioning_status: ?DeviceStatus,

    /// The device's tags.
    tags: ?[]const aws.map.StringMapEntry,

    /// The device's type.
    @"type": ?DeviceType,

    pub const json_field_names = .{
        .brand = "Brand",
        .created_time = "CreatedTime",
        .current_software = "CurrentSoftware",
        .description = "Description",
        .device_aggregated_status = "DeviceAggregatedStatus",
        .device_id = "DeviceId",
        .last_updated_time = "LastUpdatedTime",
        .latest_device_job = "LatestDeviceJob",
        .lease_expiration_time = "LeaseExpirationTime",
        .name = "Name",
        .provisioning_status = "ProvisioningStatus",
        .tags = "Tags",
        .@"type" = "Type",
    };
};
