const std = @import("std");

pub const CrossAccountFilterOption = enum {
    same_account,
    cross_account,

    pub const json_field_names = .{
        .same_account = "SameAccount",
        .cross_account = "CrossAccount",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .same_account => "SameAccount",
            .cross_account => "CrossAccount",
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
