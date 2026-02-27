/// The action to take on content advisory XDS packets. If you select
/// PASSTHROUGH, packets will not be changed. If you select STRIP, any packets
/// will be removed in output captions.
pub const VchipAction = enum {
    passthrough,
    strip,

    pub const json_field_names = .{
        .passthrough = "PASSTHROUGH",
        .strip = "STRIP",
    };
};
