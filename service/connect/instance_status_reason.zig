/// Relevant
/// details why the instance was not successfully created.
pub const InstanceStatusReason = struct {
    /// The message.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
    };
};
