const std = @import("std");

pub const UpdateType = enum {
    os,
    network,
    size,

    pub const json_field_names = .{
        .os = "OS",
        .network = "NETWORK",
        .size = "SIZE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .os => "OS",
            .network => "NETWORK",
            .size => "SIZE",
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
