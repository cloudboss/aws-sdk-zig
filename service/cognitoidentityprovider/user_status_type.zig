const std = @import("std");

pub const UserStatusType = enum {
    unconfirmed,
    confirmed,
    archived,
    compromised,
    unknown,
    reset_required,
    force_change_password,
    external_provider,

    pub const json_field_names = .{
        .unconfirmed = "UNCONFIRMED",
        .confirmed = "CONFIRMED",
        .archived = "ARCHIVED",
        .compromised = "COMPROMISED",
        .unknown = "UNKNOWN",
        .reset_required = "RESET_REQUIRED",
        .force_change_password = "FORCE_CHANGE_PASSWORD",
        .external_provider = "EXTERNAL_PROVIDER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unconfirmed => "UNCONFIRMED",
            .confirmed => "CONFIRMED",
            .archived => "ARCHIVED",
            .compromised => "COMPROMISED",
            .unknown => "UNKNOWN",
            .reset_required => "RESET_REQUIRED",
            .force_change_password => "FORCE_CHANGE_PASSWORD",
            .external_provider => "EXTERNAL_PROVIDER",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
