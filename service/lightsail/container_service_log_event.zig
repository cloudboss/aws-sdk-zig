/// Describes the log events of a container of an Amazon Lightsail container
/// service.
pub const ContainerServiceLogEvent = struct {
    /// The timestamp when the container service log event was created.
    created_at: ?i64 = null,

    /// The message of the container service log event.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .message = "message",
    };
};
