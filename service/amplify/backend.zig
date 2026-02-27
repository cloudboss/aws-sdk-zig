/// Describes the backend associated with an Amplify
/// `Branch`.
///
/// This property is available to Amplify Gen 2 apps only. When you deploy
/// an application with Amplify Gen 2, you provision the app's backend
/// infrastructure using
/// Typescript code.
pub const Backend = struct {
    /// The Amazon Resource Name (ARN) for the CloudFormation stack.
    stack_arn: ?[]const u8,

    pub const json_field_names = .{
        .stack_arn = "stackArn",
    };
};
