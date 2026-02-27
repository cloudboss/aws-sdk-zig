const OptionRestrictionRegex = @import("option_restriction_regex.zig").OptionRestrictionRegex;
const ConfigurationOptionValueType = @import("configuration_option_value_type.zig").ConfigurationOptionValueType;

/// Describes the possible values for a configuration option.
pub const ConfigurationOptionDescription = struct {
    /// An indication of which action is required if the value for this
    /// configuration option
    /// changes:
    ///
    /// * `NoInterruption` : There is no interruption to the environment or
    ///   application
    /// availability.
    ///
    /// * `RestartEnvironment` : The environment is entirely restarted, all AWS
    ///   resources
    /// are deleted and recreated, and the environment is unavailable during the
    /// process.
    ///
    /// * `RestartApplicationServer` : The environment is available the entire time.
    /// However, a short application outage occurs when the application servers on
    /// the running
    /// Amazon EC2 instances are restarted.
    change_severity: ?[]const u8,

    /// The default value for this configuration option.
    default_value: ?[]const u8,

    /// If specified, the configuration option must be a string value no longer than
    /// this
    /// value.
    max_length: ?i32,

    /// If specified, the configuration option must be a numeric value less than
    /// this
    /// value.
    max_value: ?i32,

    /// If specified, the configuration option must be a numeric value greater than
    /// this
    /// value.
    min_value: ?i32,

    /// The name of the configuration option.
    name: ?[]const u8,

    /// A unique namespace identifying the option's associated AWS resource.
    namespace: ?[]const u8,

    /// If specified, the configuration option must be a string value that satisfies
    /// this
    /// regular expression.
    regex: ?OptionRestrictionRegex,

    /// An indication of whether the user defined this configuration option:
    ///
    /// * `true` : This configuration option was defined by the user. It is a valid
    /// choice for specifying if this as an `Option to Remove` when updating
    /// configuration settings.
    ///
    /// * `false` : This configuration was not defined by the user.
    ///
    /// Constraint: You can remove only `UserDefined` options from a configuration.
    ///
    /// Valid Values: `true` | `false`
    user_defined: ?bool,

    /// If specified, values for the configuration option are selected from this
    /// list.
    value_options: ?[]const []const u8,

    /// An indication of which type of values this option has and whether it is
    /// allowable to
    /// select one or more than one of the possible values:
    ///
    /// * `Scalar` : Values for this option are a single selection from the possible
    /// values, or an unformatted string, or numeric value governed by the
    /// `MIN/MAX/Regex` constraints.
    ///
    /// * `List` : Values for this option are multiple selections from the possible
    /// values.
    ///
    /// * `Boolean` : Values for this option are either `true` or
    /// `false` .
    ///
    /// * `Json` : Values for this option are a JSON representation of a
    /// `ConfigDocument`.
    value_type: ?ConfigurationOptionValueType,
};
