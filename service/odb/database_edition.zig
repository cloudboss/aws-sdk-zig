const std = @import("std");

pub const DatabaseEdition = enum {
    standard_edition,
    enterprise_edition,

    pub const json_field_names = .{
        .standard_edition = "STANDARD_EDITION",
        .enterprise_edition = "ENTERPRISE_EDITION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .standard_edition => "STANDARD_EDITION",
            .enterprise_edition => "ENTERPRISE_EDITION",
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
