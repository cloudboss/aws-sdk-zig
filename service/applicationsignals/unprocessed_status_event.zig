const UnprocessedStatusEventFailureReason = @import("unprocessed_status_event_failure_reason.zig").UnprocessedStatusEventFailureReason;
const InstrumentationType = @import("instrumentation_type.zig").InstrumentationType;
const DynamicInstrumentationSignalType = @import("dynamic_instrumentation_signal_type.zig").DynamicInstrumentationSignalType;
const InstrumentationConfigurationStatus = @import("instrumentation_configuration_status.zig").InstrumentationConfigurationStatus;

/// A status event that could not be processed by the service.
pub const UnprocessedStatusEvent = struct {
    /// The reason why this status event could not be processed, such as throttling
    /// or validation errors.
    failed_reason: UnprocessedStatusEventFailureReason,

    /// The type of instrumentation configuration for the unprocessed status event.
    instrumentation_type: InstrumentationType,

    /// The stable hash of the instrumentation location for the unprocessed event.
    location_hash: []const u8,

    /// The telemetry signal type for the unprocessed status event.
    signal_type: DynamicInstrumentationSignalType,

    /// The status that failed to be processed.
    status: InstrumentationConfigurationStatus,

    /// The timestamp of the status event that failed to be processed.
    time: i64,

    pub const json_field_names = .{
        .failed_reason = "FailedReason",
        .instrumentation_type = "InstrumentationType",
        .location_hash = "LocationHash",
        .signal_type = "SignalType",
        .status = "Status",
        .time = "Time",
    };
};
