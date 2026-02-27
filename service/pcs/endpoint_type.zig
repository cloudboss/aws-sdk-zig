pub const EndpointType = enum {
    slurmctld,
    slurmdbd,
    slurmrestd,

    pub const json_field_names = .{
        .slurmctld = "SLURMCTLD",
        .slurmdbd = "SLURMDBD",
        .slurmrestd = "SLURMRESTD",
    };
};
