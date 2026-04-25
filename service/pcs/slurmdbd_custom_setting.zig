/// Additional settings that directly map to SlurmDBD settings.
///
/// PCS supports a subset of SlurmDBD settings. For more information, see
/// [Configuring custom SlurmDBD settings in
/// PCS](https://docs.aws.amazon.com/pcs/latest/userguide/slurmdbd-custom-settings.html) in the *PCS User Guide*.
pub const SlurmdbdCustomSetting = struct {
    /// PCS supports custom SlurmDBD settings for clusters. For more information,
    /// see [Configuring custom SlurmDBD settings in
    /// PCS](https://docs.aws.amazon.com/pcs/latest/userguide/slurmdbd-custom-settings.html) in the *PCS User Guide*.
    parameter_name: []const u8,

    /// The values for the configured SlurmDBD settings.
    parameter_value: []const u8,

    pub const json_field_names = .{
        .parameter_name = "parameterName",
        .parameter_value = "parameterValue",
    };
};
