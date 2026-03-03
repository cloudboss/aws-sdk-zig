const TimeWindow = @import("time_window.zig").TimeWindow;
const LocalTimeZoneConfig = @import("local_time_zone_config.zig").LocalTimeZoneConfig;

/// Campaign communication time config
pub const CommunicationTimeConfig = struct {
    email: ?TimeWindow = null,

    local_time_zone_config: LocalTimeZoneConfig,

    sms: ?TimeWindow = null,

    telephony: ?TimeWindow = null,

    whats_app: ?TimeWindow = null,

    pub const json_field_names = .{
        .email = "email",
        .local_time_zone_config = "localTimeZoneConfig",
        .sms = "sms",
        .telephony = "telephony",
        .whats_app = "whatsApp",
    };
};
