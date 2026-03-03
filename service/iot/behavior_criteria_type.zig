const std = @import("std");

pub const BehaviorCriteriaType = enum {
    static,
    statistical,
    machine_learning,

    pub const json_field_names = .{
        .static = "STATIC",
        .statistical = "STATISTICAL",
        .machine_learning = "MACHINE_LEARNING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .static => "STATIC",
            .statistical => "STATISTICAL",
            .machine_learning => "MACHINE_LEARNING",
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
