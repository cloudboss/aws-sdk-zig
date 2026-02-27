/// The minimum and maximum amount of total local storage, in GB, that an Amazon
/// EC2 instance uses.
pub const AwsEc2LaunchTemplateDataInstanceRequirementsTotalLocalStorageGBDetails = struct {
    /// The maximum amount of total local storage, in GB.
    max: ?f64,

    /// The minimum amount of total local storage, in GB.
    min: ?f64,

    pub const json_field_names = .{
        .max = "Max",
        .min = "Min",
    };
};
