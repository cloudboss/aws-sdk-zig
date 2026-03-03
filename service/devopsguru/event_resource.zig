/// The Amazon Web Services resource that emitted an event. Amazon Web Services
/// resource events and metrics are
/// analyzed by DevOps Guru to find anomalous behavior and provide
/// recommendations to improve your
/// operational solutions.
pub const EventResource = struct {
    /// The Amazon Resource Name (ARN) of the resource that emitted an event.
    arn: ?[]const u8 = null,

    /// The name of the resource that emitted an event.
    name: ?[]const u8 = null,

    /// The type of resource that emitted an event.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
        .@"type" = "Type",
    };
};
