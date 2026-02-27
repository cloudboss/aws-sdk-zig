/// Describes the basic structure and properties of a
/// `ManagedNotificationConfiguration`.
pub const ManagedNotificationConfigurationStructure = struct {
    /// The Amazon Resource Name (ARN) of the `ManagedNotificationConfiguration`.
    arn: []const u8,

    /// The description of the `ManagedNotificationConfiguration`.
    description: []const u8,

    /// The name of the `ManagedNotificationConfiguration`.
    name: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .description = "description",
        .name = "name",
    };
};
