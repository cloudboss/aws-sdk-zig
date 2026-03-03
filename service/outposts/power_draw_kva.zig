const std = @import("std");

pub const PowerDrawKva = enum {
    power_5_kva,
    power_10_kva,
    power_15_kva,
    power_30_kva,

    pub const json_field_names = .{
        .power_5_kva = "POWER_5_KVA",
        .power_10_kva = "POWER_10_KVA",
        .power_15_kva = "POWER_15_KVA",
        .power_30_kva = "POWER_30_KVA",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .power_5_kva => "POWER_5_KVA",
            .power_10_kva => "POWER_10_KVA",
            .power_15_kva => "POWER_15_KVA",
            .power_30_kva => "POWER_30_KVA",
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
