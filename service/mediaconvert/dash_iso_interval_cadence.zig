const std = @import("std");

/// The cadence MediaConvert follows for generating thumbnails. If set to
/// FOLLOW_IFRAME, MediaConvert generates thumbnails for each IDR frame in the
/// output (matching the GOP cadence). If set to FOLLOW_CUSTOM, MediaConvert
/// generates thumbnails according to the interval you specify in
/// thumbnailInterval.
pub const DashIsoIntervalCadence = enum {
    follow_iframe,
    follow_custom,

    pub const json_field_names = .{
        .follow_iframe = "FOLLOW_IFRAME",
        .follow_custom = "FOLLOW_CUSTOM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .follow_iframe => "FOLLOW_IFRAME",
            .follow_custom => "FOLLOW_CUSTOM",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
