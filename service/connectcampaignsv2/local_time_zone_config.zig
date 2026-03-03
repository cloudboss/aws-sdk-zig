const LocalTimeZoneDetectionType = @import("local_time_zone_detection_type.zig").LocalTimeZoneDetectionType;

/// Local time zone config
pub const LocalTimeZoneConfig = struct {
    default_time_zone: ?[]const u8 = null,

    local_time_zone_detection: ?[]const LocalTimeZoneDetectionType = null,

    pub const json_field_names = .{
        .default_time_zone = "defaultTimeZone",
        .local_time_zone_detection = "localTimeZoneDetection",
    };
};
