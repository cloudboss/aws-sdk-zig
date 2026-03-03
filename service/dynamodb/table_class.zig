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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
