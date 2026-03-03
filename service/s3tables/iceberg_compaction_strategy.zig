const std = @import("std");

pub const IcebergCompactionStrategy = enum {
    auto,
    binpack,
    sort,
    zorder,

    pub const json_field_names = .{
        .auto = "auto",
        .binpack = "binpack",
        .sort = "sort",
        .zorder = "z-order",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto => "auto",
            .binpack => "binpack",
            .sort => "sort",
            .zorder => "z-order",
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
