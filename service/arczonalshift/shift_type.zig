pub const ShiftType = enum {
    zonal_shift,
    practice_run,
    fis_experiment,
    zonal_autoshift,

    pub const json_field_names = .{
        .zonal_shift = "ZONAL_SHIFT",
        .practice_run = "PRACTICE_RUN",
        .fis_experiment = "FIS_EXPERIMENT",
        .zonal_autoshift = "ZONAL_AUTOSHIFT",
    };
};
