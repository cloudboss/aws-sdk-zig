const std = @import("std");

pub const EgressFilterType = enum {
    allow_all,
    drop_all,

    pub const json_field_names = .{
        .allow_all = "ALLOW_ALL",
        .drop_all = "DROP_ALL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .allow_all => "ALLOW_ALL",
            .drop_all => "DROP_ALL",
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
