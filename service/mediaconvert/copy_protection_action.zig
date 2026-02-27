/// The action to take on copy and redistribution control XDS packets. If you
/// select PASSTHROUGH, packets will not be changed. If you select STRIP, any
/// packets will be removed in output captions.
pub const CopyProtectionAction = enum {
    passthrough,
    strip,

    pub const json_field_names = .{
        .passthrough = "PASSTHROUGH",
        .strip = "STRIP",
    };
};
