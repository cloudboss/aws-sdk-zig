const std = @import("std");

pub const TableClass = enum {
    standard,
    standard_infrequent_access,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .standard_infrequent_access = "STANDARD_INFREQUENT_ACCESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .standard => "STANDARD",
            .standard_infrequent_access => "STANDARD_INFREQUENT_ACCESS",
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
