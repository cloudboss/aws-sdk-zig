const std = @import("std");

pub const ComputeType = enum {
    acu_1,
    acu_2,

    pub const json_field_names = .{
        .acu_1 = "ACU_1",
        .acu_2 = "ACU_2",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .acu_1 => "ACU_1",
            .acu_2 => "ACU_2",
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
