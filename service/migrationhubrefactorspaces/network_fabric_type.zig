const std = @import("std");

pub const NetworkFabricType = enum {
    transit_gateway,
    none,

    pub const json_field_names = .{
        .transit_gateway = "TRANSIT_GATEWAY",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .transit_gateway => "TRANSIT_GATEWAY",
            .none => "NONE",
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
