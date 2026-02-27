const SrtCallerSourceRequest = @import("srt_caller_source_request.zig").SrtCallerSourceRequest;
const SrtListenerSettingsRequest = @import("srt_listener_settings_request.zig").SrtListenerSettingsRequest;

/// Configures the settings for SRT inputs. Provide either srtCallerSources (for
/// SRT_CALLER type) OR srtListenerSettings (for SRT_LISTENER type), not both.
pub const SrtSettingsRequest = struct {
    srt_caller_sources: ?[]const SrtCallerSourceRequest,

    srt_listener_settings: ?SrtListenerSettingsRequest,

    pub const json_field_names = .{
        .srt_caller_sources = "SrtCallerSources",
        .srt_listener_settings = "SrtListenerSettings",
    };
};
