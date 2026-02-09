/// Configuration that defines the scaling behavior for a Lambda Managed
/// Instances function, including the minimum and maximum number of execution
/// environments that can be provisioned.
pub const FunctionScalingConfig = struct {
    /// The maximum number of execution environments that can be provisioned for the
    /// function.
    max_execution_environments: ?i32,

    /// The minimum number of execution environments to maintain for the function.
    min_execution_environments: ?i32,
};
