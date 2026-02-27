const SrtCallerSource = @import("srt_caller_source.zig").SrtCallerSource;
const SrtListenerSettings = @import("srt_listener_settings.zig").SrtListenerSettings;

/// The configured settings for SRT inputs (caller and listener).
pub const SrtSettings = struct {
    srt_caller_sources: ?[]const SrtCallerSource,

    srt_listener_settings: ?SrtListenerSettings,

    pub const json_field_names = .{
        .srt_caller_sources = "SrtCallerSources",
        .srt_listener_settings = "SrtListenerSettings",
    };
};
