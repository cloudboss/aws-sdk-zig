const FuotaTaskEventLogOption = @import("fuota_task_event_log_option.zig").FuotaTaskEventLogOption;
const LogLevel = @import("log_level.zig").LogLevel;
const FuotaTaskType = @import("fuota_task_type.zig").FuotaTaskType;

/// The log options for FUOTA tasks and can be used to set log levels for a
/// specific type
/// of FUOTA task.
pub const FuotaTaskLogOption = struct {
    events: ?[]const FuotaTaskEventLogOption,

    log_level: LogLevel,

    /// The FUOTA task type.
    type: FuotaTaskType,

    pub const json_field_names = .{
        .events = "Events",
        .log_level = "LogLevel",
        .type = "Type",
    };
};
