const std = @import("std");

pub const AllowedUserAction = enum {
    call,
    discard,

    pub const json_field_names = .{
        .call = "CALL",
        .discard = "DISCARD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .call => "CALL",
            .discard => "DISCARD",
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
