/// Additional settings that directly map to Cgroup settings.
///
/// PCS supports a subset of Cgroup settings. For more information, see
/// [Configuring custom Cgroup settings in
/// PCS](https://docs.aws.amazon.com/pcs/latest/userguide/cgroup-custom-settings.html) in the *PCS User Guide*.
pub const CgroupCustomSetting = struct {
    /// PCS supports custom Cgroup settings for clusters. For more information, see
    /// [Configuring custom Cgroup settings in
    /// PCS](https://docs.aws.amazon.com/pcs/latest/userguide/cgroup-custom-settings.html) in the *PCS User Guide*.
    parameter_name: []const u8,

    /// The values for the configured Cgroup settings.
    parameter_value: []const u8,

    pub const json_field_names = .{
        .parameter_name = "parameterName",
        .parameter_value = "parameterValue",
    };
};
