const LambdaCodeHook = @import("lambda_code_hook.zig").LambdaCodeHook;

/// Contains information about code hooks that Amazon Lex calls during a
/// conversation.
pub const CodeHookSpecification = struct {
    lambda_code_hook: LambdaCodeHook,

    pub const json_field_names = .{
        .lambda_code_hook = "lambdaCodeHook",
    };
};
