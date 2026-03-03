/// A specification identifying an individual configuration option along with
/// its current
/// value. For a list of possible namespaces and option values, see [Option
/// Values](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/command-options.html) in the
/// *AWS Elastic Beanstalk Developer Guide*.
pub const ConfigurationOptionSetting = struct {
    /// A unique namespace that identifies the option's associated AWS resource.
    namespace: ?[]const u8 = null,

    /// The name of the configuration option.
    option_name: ?[]const u8 = null,

    /// A unique resource name for the option setting. Use it for a time–based
    /// scaling configuration option.
    resource_name: ?[]const u8 = null,

    /// The current value for the configuration option.
    value: ?[]const u8 = null,
};
