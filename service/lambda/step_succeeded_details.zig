const EventResult = @import("event_result.zig").EventResult;
const RetryDetails = @import("retry_details.zig").RetryDetails;

/// Details about a step that succeeded.
pub const StepSucceededDetails = struct {
    /// The response payload from the successful operation.
    result: EventResult,

    /// Information about retry attempts for this step operation.
    retry_details: RetryDetails,
};
