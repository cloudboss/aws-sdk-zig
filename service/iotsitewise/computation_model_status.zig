const ErrorDetails = @import("error_details.zig").ErrorDetails;
const ComputationModelState = @import("computation_model_state.zig").ComputationModelState;

/// Contains current status information for a computation model.
pub const ComputationModelStatus = struct {
    @"error": ?ErrorDetails = null,

    /// The current state of the computation model.
    state: ComputationModelState,

    pub const json_field_names = .{
        .@"error" = "error",
        .state = "state",
    };
};
