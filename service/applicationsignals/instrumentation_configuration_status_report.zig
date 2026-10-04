const InstrumentationErrorCause = @import("instrumentation_error_cause.zig").InstrumentationErrorCause;
const InstrumentationType = @import("instrumentation_type.zig").InstrumentationType;
const DynamicInstrumentationSignalType = @import("dynamic_instrumentation_signal_type.zig").DynamicInstrumentationSignalType;
const InstrumentationConfigurationStatus = @import("instrumentation_configuration_status.zig").InstrumentationConfigurationStatus;

/// The status of a single instrumentation configuration reported by an SDK
/// instance.
pub const InstrumentationConfigurationStatusReport = struct {
    /// The error cause when the status is `ERROR`, such as the file or method not
    /// being found.
    error_cause: ?InstrumentationErrorCause = null,

    /// The type of instrumentation configuration being reported.
    instrumentation_type: InstrumentationType,

    /// The stable hash of the instrumentation location that identifies the
    /// configuration being reported.
    location_hash: []const u8,

    /// The telemetry signal type for this instrumentation configuration.
    signal_type: DynamicInstrumentationSignalType,

    /// The status of the instrumentation configuration: `READY`, `ERROR`, `ACTIVE`,
    /// or `DISABLED`.
    status: InstrumentationConfigurationStatus,

    /// The timestamp when the status event occurred.
    time: i64,

    pub const json_field_names = .{
        .error_cause = "ErrorCause",
        .instrumentation_type = "InstrumentationType",
        .location_hash = "LocationHash",
        .signal_type = "SignalType",
        .status = "Status",
        .time = "Time",
    };
};
