const aws = @import("aws");

/// Identifying information about the device.
pub const DeviceSummary = struct {
    /// The ID of the job used to order the device.
    associated_with_job: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the device.
    managed_device_arn: ?[]const u8,

    /// The ID of the device.
    managed_device_id: ?[]const u8,

    /// Optional metadata that you assign to a resource. You can use tags to
    /// categorize a resource
    /// in different ways, such as by purpose, owner, or environment.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .associated_with_job = "associatedWithJob",
        .managed_device_arn = "managedDeviceArn",
        .managed_device_id = "managedDeviceId",
        .tags = "tags",
    };
};
