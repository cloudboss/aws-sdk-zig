const std = @import("std");

pub const EphemerisInvalidReason = enum {
    /// Provided spacecraft identifiers such as spacecraft NORAD Id are invalid
    metadata_invalid,
    /// Start, end, or expiration time(s) are invalid for the provided ephemeris
    time_range_invalid,
    /// Provided ephemeris defines invalid spacecraft trajectory
    trajectory_invalid,
    /// Provided KMS key is invalid
    kms_key_invalid,
    /// Internal Service Error occurred while processing ephemeris
    validation_error,

    pub const json_field_names = .{
        .metadata_invalid = "METADATA_INVALID",
        .time_range_invalid = "TIME_RANGE_INVALID",
        .trajectory_invalid = "TRAJECTORY_INVALID",
        .kms_key_invalid = "KMS_KEY_INVALID",
        .validation_error = "VALIDATION_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .metadata_invalid => "METADATA_INVALID",
            .time_range_invalid => "TIME_RANGE_INVALID",
            .trajectory_invalid => "TRAJECTORY_INVALID",
            .kms_key_invalid => "KMS_KEY_INVALID",
            .validation_error => "VALIDATION_ERROR",
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
