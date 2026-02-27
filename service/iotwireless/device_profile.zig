/// Describes a device profile.
pub const DeviceProfile = struct {
    /// The Amazon Resource Name of the resource.
    arn: ?[]const u8,

    /// The ID of the device profile.
    id: ?[]const u8,

    /// The name of the resource.
    name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .name = "Name",
    };
};
