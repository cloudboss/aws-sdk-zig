/// Smooth Group Stream Manifest Behavior
pub const SmoothGroupStreamManifestBehavior = enum {
    do_not_send,
    send,

    pub const json_field_names = .{
        .do_not_send = "DO_NOT_SEND",
        .send = "SEND",
    };
};
