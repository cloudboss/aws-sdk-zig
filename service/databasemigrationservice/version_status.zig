const std = @import("std");

pub const VersionStatus = enum {
    up_to_date,
    outdated,
    unsupported,

    pub const json_field_names = .{
        .up_to_date = "UP_TO_DATE",
        .outdated = "OUTDATED",
        .unsupported = "UNSUPPORTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .up_to_date => "UP_TO_DATE",
            .outdated => "OUTDATED",
            .unsupported => "UNSUPPORTED",
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
