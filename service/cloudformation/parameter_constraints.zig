/// A set of criteria that CloudFormation uses to validate parameter values.
/// Although other
/// constraints might be defined in the stack template, CloudFormation returns
/// only the
/// `AllowedValues` property.
pub const ParameterConstraints = struct {
    /// A list of values that are permitted for a parameter.
    allowed_values: ?[]const []const u8,
};
