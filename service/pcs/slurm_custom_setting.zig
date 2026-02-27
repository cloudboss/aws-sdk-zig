/// Additional settings that directly map to Slurm settings.
///
/// PCS supports a subset of Slurm settings. For more information, see
/// [Configuring custom Slurm settings in
/// PCS](https://docs.aws.amazon.com/pcs/latest/userguide/slurm-custom-settings.html) in the *PCS User Guide*.
pub const SlurmCustomSetting = struct {
    /// PCS supports custom Slurm settings for clusters, compute node groups, and
    /// queues. For more information, see [Configuring custom Slurm settings in
    /// PCS](https://docs.aws.amazon.com/pcs/latest/userguide/slurm-custom-settings.html) in the *PCS User Guide*.
    parameter_name: []const u8,

    /// The values for the configured Slurm settings.
    parameter_value: []const u8,

    pub const json_field_names = .{
        .parameter_name = "parameterName",
        .parameter_value = "parameterValue",
    };
};
