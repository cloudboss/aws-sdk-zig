/// The `Parameter` data type.
pub const Parameter = struct {
    /// The key associated with the parameter. If you don't specify a key and value
    /// for a particular
    /// parameter, CloudFormation uses the default value that's specified in your
    /// template.
    parameter_key: ?[]const u8 = null,

    /// The input value associated with the parameter.
    parameter_value: ?[]const u8 = null,

    /// Read-only. The value that corresponds to a Systems Manager parameter key.
    /// This field is returned only
    /// for Systems Manager parameter types in the template. For more information,
    /// see [Specify
    /// existing resources at runtime with CloudFormation-supplied parameter
    /// types](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cloudformation-supplied-parameter-types.html) in the
    /// *CloudFormation User Guide*.
    resolved_value: ?[]const u8 = null,

    /// During a stack update, use the existing parameter value that the stack is
    /// using for a given
    /// parameter key. If you specify `true`, do not specify a parameter value.
    use_previous_value: ?bool = null,
};
