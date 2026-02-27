const LambdaUngracefulBehavior = @import("lambda_ungraceful_behavior.zig").LambdaUngracefulBehavior;

/// Configuration for handling failures when invoking Lambda functions.
pub const LambdaUngraceful = struct {
    /// The ungraceful behavior for a Lambda function, which must be set to `skip`.
    behavior: LambdaUngracefulBehavior = "skip",

    pub const json_field_names = .{
        .behavior = "behavior",
    };
};
