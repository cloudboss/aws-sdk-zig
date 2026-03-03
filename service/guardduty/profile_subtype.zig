const std = @import("std");

pub const ProfileSubtype = enum {
    frequent,
    infrequent,
    unseen,
    rare,

    pub const json_field_names = .{
        .frequent = "FREQUENT",
        .infrequent = "INFREQUENT",
        .unseen = "UNSEEN",
        .rare = "RARE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .frequent => "FREQUENT",
            .infrequent => "INFREQUENT",
            .unseen => "UNSEEN",
            .rare => "RARE",
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
