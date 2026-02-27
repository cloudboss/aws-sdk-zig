pub const DatePartitionSequenceValue = enum {
    yyyymmdd,
    yyyymmddhh,
    yyyymm,
    mmyyyydd,
    ddmmyyyy,

    pub const json_field_names = .{
        .yyyymmdd = "YYYYMMDD",
        .yyyymmddhh = "YYYYMMDDHH",
        .yyyymm = "YYYYMM",
        .mmyyyydd = "MMYYYYDD",
        .ddmmyyyy = "DDMMYYYY",
    };
};
