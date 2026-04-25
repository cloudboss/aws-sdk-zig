const std = @import("std");

pub const CapacityOptionType = enum {
    on_demand,
    spot,
    reserved,

    pub const json_field_names = .{
        .on_demand = "ON_DEMAND",
        .spot = "SPOT",
        .reserved = "RESERVED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .on_demand => "ON_DEMAND",
            .spot => "SPOT",
            .reserved => "RESERVED",
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
