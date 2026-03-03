const std = @import("std");

pub const OCSFVersion = enum {
    v1_1,
    v1_5,

    pub const json_field_names = .{
        .v1_1 = "V1.1",
        .v1_5 = "V1.5",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .v1_1 => "V1.1",
            .v1_5 => "V1.5",
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
