pub const OntapVolumeType = enum {
    rw,
    dp,
    ls,

    pub const json_field_names = .{
        .rw = "RW",
        .dp = "DP",
        .ls = "LS",
    };
};
