/// The `Export` structure describes the exported output values for a stack.
///
/// For more information, see [Get exported outputs from
/// a deployed CloudFormation
/// stack](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-exports.html).
pub const Export = struct {
    /// The stack that contains the exported output name and value.
    exporting_stack_id: ?[]const u8,

    /// The name of exported output value. Use this name and the `Fn::ImportValue`
    /// function to import the associated value into other stacks. The name is
    /// defined in the
    /// `Export` field in the associated stack's `Outputs` section.
    name: ?[]const u8,

    /// The value of the exported output, such as a resource physical ID. This value
    /// is defined in
    /// the `Export` field in the associated stack's `Outputs` section.
    value: ?[]const u8,
};
