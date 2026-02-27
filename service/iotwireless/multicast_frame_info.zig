/// `FrameInfo` of your multicast group resources for the trace content. Use
/// FrameInfo to debug the multicast communication between your multicast groups
/// and the
/// network server.
pub const MulticastFrameInfo = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
