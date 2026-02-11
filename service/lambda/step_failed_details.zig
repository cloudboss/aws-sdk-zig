const EventError = @import("event_error.zig").EventError;
const RetryDetails = @import("retry_details.zig").RetryDetails;

/// Details about a step that failed.
pub const StepFailedDetails = struct {
    /// Details about the step failure.
    @"error": EventError,

    /// Information about retry attempts for this step operation.
    retry_details: RetryDetails,

    pub const json_field_names = .{
        .@"error" = "Error",
        .retry_details = "RetryDetails",
    };
};
