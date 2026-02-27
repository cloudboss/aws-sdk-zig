/// Represents the results of an event submitted to an event bus.
///
/// If the submission was successful, the entry has the event ID in it.
/// Otherwise, you can use
/// the error code and error message to identify the problem with the entry.
///
/// For information about the errors that are common to all actions, see [Common
/// Errors](https://docs.aws.amazon.com/eventbridge/latest/APIReference/CommonErrors.html).
pub const PutEventsResultEntry = struct {
    /// The error code that indicates why the event submission failed.
    ///
    /// Retryable errors include:
    ///
    /// * `
    /// [InternalFailure](https://docs.aws.amazon.com/eventbridge/latest/APIReference/CommonErrors.html)
    /// `
    ///
    /// The request processing has failed because of an unknown error, exception or
    /// failure.
    ///
    /// * `
    /// [ThrottlingException](https://docs.aws.amazon.com/eventbridge/latest/APIReference/CommonErrors.html)
    /// `
    ///
    /// The request was denied due to request throttling.
    ///
    /// Non-retryable errors include:
    ///
    /// * `
    /// [AccessDeniedException](https://docs.aws.amazon.com/eventbridge/latest/APIReference/CommonErrors.html)
    /// `
    ///
    /// You do not have sufficient access to perform this action.
    ///
    /// * `InvalidAccountIdException`
    ///
    /// The account ID provided is not valid.
    ///
    /// * `InvalidArgument`
    ///
    /// A specified parameter is not valid.
    ///
    /// * `MalformedDetail`
    ///
    /// The JSON provided is not valid.
    ///
    /// * `RedactionFailure`
    ///
    /// Redacting the CloudTrail event failed.
    ///
    /// * `NotAuthorizedForSourceException`
    ///
    /// You do not have permissions to publish events with this source onto this
    /// event
    /// bus.
    ///
    /// * `NotAuthorizedForDetailTypeException`
    ///
    /// You do not have permissions to publish events with this detail type onto
    /// this event
    /// bus.
    error_code: ?[]const u8,

    /// The error message that explains why the event submission failed.
    error_message: ?[]const u8,

    /// The ID of the event.
    event_id: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .event_id = "EventId",
    };
};
