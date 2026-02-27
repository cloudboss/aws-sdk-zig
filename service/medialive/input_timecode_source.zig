/// Documentation update needed
pub const InputTimecodeSource = enum {
    zerobased,
    embedded,

    pub const json_field_names = .{
        .zerobased = "ZEROBASED",
        .embedded = "EMBEDDED",
    };
};
