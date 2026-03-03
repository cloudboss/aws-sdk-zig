const std = @import("std");

pub const NetworkInterfaceStatus = enum {
    available,
    associated,
    attaching,
    in_use,
    detaching,

    pub const json_field_names = .{
        .available = "available",
        .associated = "associated",
        .attaching = "attaching",
        .in_use = "in-use",
        .detaching = "detaching",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .available => "available",
            .associated => "associated",
            .attaching => "attaching",
            .in_use => "in-use",
            .detaching => "detaching",
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
