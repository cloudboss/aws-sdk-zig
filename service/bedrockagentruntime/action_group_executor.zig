const CustomControlMethod = @import("custom_control_method.zig").CustomControlMethod;

/// Contains details about the Lambda function containing the business logic
/// that is carried out upon invoking the action or the custom control method
/// for handling the information elicited from the user.
pub const ActionGroupExecutor = union(enum) {
    /// To return the action group invocation results directly in the
    /// `InvokeInlineAgent` response, specify `RETURN_CONTROL`.
    custom_control: ?CustomControlMethod,
    /// The Amazon Resource Name (ARN) of the Lambda function containing the
    /// business logic that is carried out upon invoking the action.
    lambda: ?[]const u8,

    pub const json_field_names = .{
        .custom_control = "customControl",
        .lambda = "lambda",
    };
};
