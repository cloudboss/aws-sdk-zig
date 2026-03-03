const AWSLocation = @import("aws_location.zig").AWSLocation;
const Location = @import("location.zig").Location;
const DeviceState = @import("device_state.zig").DeviceState;
const Tag = @import("tag.zig").Tag;

/// Describes a device.
pub const Device = struct {
    /// The Amazon Web Services location of the device.
    aws_location: ?AWSLocation = null,

    /// The date and time that the site was created.
    created_at: ?i64 = null,

    /// The description of the device.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the device.
    device_arn: ?[]const u8 = null,

    /// The ID of the device.
    device_id: ?[]const u8 = null,

    /// The ID of the global network.
    global_network_id: ?[]const u8 = null,

    /// The site location.
    location: ?Location = null,

    /// The device model.
    model: ?[]const u8 = null,

    /// The device serial number.
    serial_number: ?[]const u8 = null,

    /// The site ID.
    site_id: ?[]const u8 = null,

    /// The device state.
    state: ?DeviceState = null,

    /// The tags for the device.
    tags: ?[]const Tag = null,

    /// The device type.
    @"type": ?[]const u8 = null,

    /// The device vendor.
    vendor: ?[]const u8 = null,

    pub const json_field_names = .{
        .aws_location = "AWSLocation",
        .created_at = "CreatedAt",
        .description = "Description",
        .device_arn = "DeviceArn",
        .device_id = "DeviceId",
        .global_network_id = "GlobalNetworkId",
        .location = "Location",
        .model = "Model",
        .serial_number = "SerialNumber",
        .site_id = "SiteId",
        .state = "State",
        .tags = "Tags",
        .@"type" = "Type",
        .vendor = "Vendor",
    };
};
