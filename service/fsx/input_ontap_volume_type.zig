pub const InputOntapVolumeType = enum {
    rw,
    dp,

    pub const json_field_names = .{
        .rw = "RW",
        .dp = "DP",
    };
};
