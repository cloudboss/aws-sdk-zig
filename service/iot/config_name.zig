const std = @import("std");

pub const ConfigName = enum {
    cert_age_threshold_in_days,
    cert_expiration_threshold_in_days,

    pub const json_field_names = .{
        .cert_age_threshold_in_days = "CERT_AGE_THRESHOLD_IN_DAYS",
        .cert_expiration_threshold_in_days = "CERT_EXPIRATION_THRESHOLD_IN_DAYS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cert_age_threshold_in_days => "CERT_AGE_THRESHOLD_IN_DAYS",
            .cert_expiration_threshold_in_days => "CERT_EXPIRATION_THRESHOLD_IN_DAYS",
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
