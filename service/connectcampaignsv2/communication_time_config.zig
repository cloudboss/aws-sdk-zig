const TimeWindow = @import("time_window.zig").TimeWindow;
const LocalTimeZoneConfig = @import("local_time_zone_config.zig").LocalTimeZoneConfig;

/// Campaign communication time config
pub const CommunicationTimeConfig = struct {
    email: ?TimeWindow,

    local_time_zone_config: LocalTimeZoneConfig,

    sms: ?TimeWindow,

    telephony: ?TimeWindow,

    whats_app: ?TimeWindow,

    pub const json_field_names = .{
        .email = "email",
        .local_time_zone_config = "localTimeZoneConfig",
        .sms = "sms",
        .telephony = "telephony",
        .whats_app = "whatsApp",
    };
};
