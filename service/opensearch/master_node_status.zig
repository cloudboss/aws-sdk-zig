const std = @import("std");

pub const MasterNodeStatus = enum {
    available,
    un_available,

    pub const json_field_names = .{
        .available = "Available",
        .un_available = "UnAvailable",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .available => "Available",
            .un_available => "UnAvailable",
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
