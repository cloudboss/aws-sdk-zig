const InstrumentationErrorCause = @import("instrumentation_error_cause.zig").InstrumentationErrorCause;

/// A status event for an instrumentation configuration returned by
/// `GetInstrumentationConfigurationStatus`. Events include the timestamp and,
/// for errors, an error cause.
pub const InstrumentationStatusEvent = struct {
    /// The error cause when the status is `ERROR`.
    error_cause: ?InstrumentationErrorCause = null,

    /// The time when the status was reported, rounded to the nearest minute.
    time: i64,

    pub const json_field_names = .{
        .error_cause = "ErrorCause",
        .time = "Time",
    };
};
