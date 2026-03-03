const std = @import("std");

pub const ContainerGroupType = enum {
    game_server,
    per_instance,

    pub const json_field_names = .{
        .game_server = "GAME_SERVER",
        .per_instance = "PER_INSTANCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .game_server => "GAME_SERVER",
            .per_instance => "PER_INSTANCE",
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
