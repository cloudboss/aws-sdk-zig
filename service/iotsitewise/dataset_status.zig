const ErrorDetails = @import("error_details.zig").ErrorDetails;
const DatasetState = @import("dataset_state.zig").DatasetState;

/// The status of the dataset. This contains the state and any error messages.
/// The state is
/// `ACTIVE` when ready to use.
pub const DatasetStatus = struct {
    @"error": ?ErrorDetails,

    /// The current status of the dataset.
    state: DatasetState,

    pub const json_field_names = .{
        .@"error" = "error",
        .state = "state",
    };
};
