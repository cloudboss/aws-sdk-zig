const std = @import("std");

pub const InterfaceTypeEnum = enum {
    interface,
    efa,
    efa_only,

    pub const json_field_names = .{
        .interface = "interface",
        .efa = "efa",
        .efa_only = "efa-only",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .interface => "interface",
            .efa => "efa",
            .efa_only => "efa-only",
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
