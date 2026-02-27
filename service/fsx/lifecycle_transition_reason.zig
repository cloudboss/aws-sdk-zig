/// Describes why a resource lifecycle state changed.
pub const LifecycleTransitionReason = struct {
    message: ?[]const u8,

    pub const json_field_names = .{
        .message = "Message",
    };
};
