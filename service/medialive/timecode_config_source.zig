/// Timecode Config Source
pub const TimecodeConfigSource = enum {
    embedded,
    systemclock,
    zerobased,

    pub const json_field_names = .{
        .embedded = "EMBEDDED",
        .systemclock = "SYSTEMCLOCK",
        .zerobased = "ZEROBASED",
    };
};
