const State = @import("state.zig").State;

/// Information about a function version that uses a specific capacity provider,
/// including its ARN and current state.
pub const FunctionVersionsByCapacityProviderListItem = struct {
    /// The Amazon Resource Name (ARN) of the function version.
    function_arn: []const u8,

    /// The current state of the function version.
    state: State,

    pub const json_field_names = .{
        .function_arn = "FunctionArn",
        .state = "State",
    };
};
