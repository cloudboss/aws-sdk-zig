const std = @import("std");

pub const VersionFailureReasonCode = enum {
    internal_error,
    invalid_satellite_arn,
    invalid_update_contact_request,
    ephemeris_not_found,
    ephemeris_time_range_invalid,
    ephemeris_not_enabled,
    satellite_does_not_match_ephemeris,
    not_onboarded_to_azel_ephemeris,
    azel_ephemeris_not_found,
    azel_ephemeris_wrong_ground_station,
    azel_ephemeris_invalid_status,
    azel_ephemeris_time_range_invalid,

    pub const json_field_names = .{
        .internal_error = "INTERNAL_ERROR",
        .invalid_satellite_arn = "INVALID_SATELLITE_ARN",
        .invalid_update_contact_request = "INVALID_UPDATE_CONTACT_REQUEST",
        .ephemeris_not_found = "EPHEMERIS_NOT_FOUND",
        .ephemeris_time_range_invalid = "EPHEMERIS_TIME_RANGE_INVALID",
        .ephemeris_not_enabled = "EPHEMERIS_NOT_ENABLED",
        .satellite_does_not_match_ephemeris = "SATELLITE_DOES_NOT_MATCH_EPHEMERIS",
        .not_onboarded_to_azel_ephemeris = "NOT_ONBOARDED_TO_AZEL_EPHEMERIS",
        .azel_ephemeris_not_found = "AZEL_EPHEMERIS_NOT_FOUND",
        .azel_ephemeris_wrong_ground_station = "AZEL_EPHEMERIS_WRONG_GROUND_STATION",
        .azel_ephemeris_invalid_status = "AZEL_EPHEMERIS_INVALID_STATUS",
        .azel_ephemeris_time_range_invalid = "AZEL_EPHEMERIS_TIME_RANGE_INVALID",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .internal_error => "INTERNAL_ERROR",
            .invalid_satellite_arn => "INVALID_SATELLITE_ARN",
            .invalid_update_contact_request => "INVALID_UPDATE_CONTACT_REQUEST",
            .ephemeris_not_found => "EPHEMERIS_NOT_FOUND",
            .ephemeris_time_range_invalid => "EPHEMERIS_TIME_RANGE_INVALID",
            .ephemeris_not_enabled => "EPHEMERIS_NOT_ENABLED",
            .satellite_does_not_match_ephemeris => "SATELLITE_DOES_NOT_MATCH_EPHEMERIS",
            .not_onboarded_to_azel_ephemeris => "NOT_ONBOARDED_TO_AZEL_EPHEMERIS",
            .azel_ephemeris_not_found => "AZEL_EPHEMERIS_NOT_FOUND",
            .azel_ephemeris_wrong_ground_station => "AZEL_EPHEMERIS_WRONG_GROUND_STATION",
            .azel_ephemeris_invalid_status => "AZEL_EPHEMERIS_INVALID_STATUS",
            .azel_ephemeris_time_range_invalid => "AZEL_EPHEMERIS_TIME_RANGE_INVALID",
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
