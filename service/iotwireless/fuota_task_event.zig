/// The event for a log message, if the log message is tied to a FUOTA task.
pub const FuotaTaskEvent = enum {
    fuota,

    pub const json_field_names = .{
        .fuota = "Fuota",
    };
};
