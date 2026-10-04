const std = @import("std");

pub const ModifyAvailabilityZoneOptInStatus = enum {
    opted_in,
    not_opted_in,

    pub const json_field_names = .{
        .opted_in = "opted-in",
        .not_opted_in = "not-opted-in",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .opted_in => "opted-in",
            .not_opted_in => "not-opted-in",
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
