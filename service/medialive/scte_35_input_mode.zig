/// Whether the SCTE-35 input should be the active input or a fixed input.
pub const Scte35InputMode = enum {
    fixed,
    follow_active,

    pub const json_field_names = .{
        .fixed = "FIXED",
        .follow_active = "FOLLOW_ACTIVE",
    };
};
