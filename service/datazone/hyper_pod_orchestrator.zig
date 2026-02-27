pub const HyperPodOrchestrator = enum {
    eks,
    slurm,

    pub const json_field_names = .{
        .eks = "EKS",
        .slurm = "SLURM",
    };
};
