pub const SchedulerType = enum {
    slurm,

    pub const json_field_names = .{
        .slurm = "SLURM",
    };
};
