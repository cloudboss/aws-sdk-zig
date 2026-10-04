const LocalTimeZoneDetectionType = @import("local_time_zone_detection_type.zig").LocalTimeZoneDetectionType;
const LocalTimeZoneDetectionScope = @import("local_time_zone_detection_scope.zig").LocalTimeZoneDetectionScope;

/// Local time zone config
pub const LocalTimeZoneConfig = struct {
    default_time_zone: ?[]const u8 = null,

    local_time_zone_detection: ?[]const LocalTimeZoneDetectionType = null,

    local_time_zone_detection_scope: ?LocalTimeZoneDetectionScope = null,

    pub const json_field_names = .{
        .default_time_zone = "defaultTimeZone",
        .local_time_zone_detection = "localTimeZoneDetection",
        .local_time_zone_detection_scope = "localTimeZoneDetectionScope",
    };
};
