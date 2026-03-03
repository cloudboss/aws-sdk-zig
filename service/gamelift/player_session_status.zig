const std = @import("std");

pub const PlayerSessionStatus = enum {
    reserved,
    active,
    completed,
    timedout,

    pub const json_field_names = .{
        .reserved = "RESERVED",
        .active = "ACTIVE",
        .completed = "COMPLETED",
        .timedout = "TIMEDOUT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .reserved => "RESERVED",
            .active => "ACTIVE",
            .completed => "COMPLETED",
            .timedout => "TIMEDOUT",
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
