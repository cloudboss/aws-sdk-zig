/// An activity that adds data from the IoT device registry to your message.
pub const DeviceRegistryEnrichActivity = struct {
    /// The name of the attribute that is added to the message.
    attribute: []const u8,

    /// The name of the `deviceRegistryEnrich` activity.
    name: []const u8,

    /// The next activity in the pipeline.
    next: ?[]const u8 = null,

    /// The ARN of the role that allows access to the device's registry information.
    role_arn: []const u8,

    /// The name of the IoT device whose registry information is added to the
    /// message.
    thing_name: []const u8,

    pub const json_field_names = .{
        .attribute = "attribute",
        .name = "name",
        .next = "next",
        .role_arn = "roleArn",
        .thing_name = "thingName",
    };
};
