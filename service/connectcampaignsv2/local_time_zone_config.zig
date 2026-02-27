const LocalTimeZoneDetectionType = @import("local_time_zone_detection_type.zig").LocalTimeZoneDetectionType;

/// Local time zone config
pub const LocalTimeZoneConfig = struct {
    default_time_zone: ?[]const u8,

    local_time_zone_detection: ?[]const LocalTimeZoneDetectionType,

    pub const json_field_names = .{
        .default_time_zone = "defaultTimeZone",
        .local_time_zone_detection = "localTimeZoneDetection",
    };
};
