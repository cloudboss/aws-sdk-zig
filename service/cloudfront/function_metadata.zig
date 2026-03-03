const FunctionStage = @import("function_stage.zig").FunctionStage;

/// Contains metadata about a CloudFront function.
pub const FunctionMetadata = struct {
    /// The date and time when the function was created.
    created_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the function. The ARN uniquely identifies
    /// the function.
    function_arn: []const u8,

    /// The date and time when the function was most recently updated.
    last_modified_time: i64,

    /// The stage that the function is in, either `DEVELOPMENT` or `LIVE`.
    ///
    /// When a function is in the `DEVELOPMENT` stage, you can test the function
    /// with `TestFunction`, and update it with `UpdateFunction`.
    ///
    /// When a function is in the `LIVE` stage, you can attach the function to a
    /// distribution's cache behavior, using the function's ARN.
    stage: ?FunctionStage = null,
};
