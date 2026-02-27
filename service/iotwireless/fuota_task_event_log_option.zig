const FuotaTaskEvent = @import("fuota_task_event.zig").FuotaTaskEvent;
const LogLevel = @import("log_level.zig").LogLevel;

/// The log options for a FUOTA task event and can be used to set log levels for
/// a
/// specific FUOTA task event.
///
/// For a LoRaWAN FUOTA task, the only possible event for a log message is
/// `Fuota`.
pub const FuotaTaskEventLogOption = struct {
    event: FuotaTaskEvent,

    log_level: LogLevel,

    pub const json_field_names = .{
        .event = "Event",
        .log_level = "LogLevel",
    };
};
