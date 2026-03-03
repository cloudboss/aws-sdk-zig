const std = @import("std");

pub const StackDriftStatus = enum {
    drifted,
    in_sync,
    unknown,
    not_checked,

    pub const json_field_names = .{
        .drifted = "DRIFTED",
        .in_sync = "IN_SYNC",
        .unknown = "UNKNOWN",
        .not_checked = "NOT_CHECKED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .drifted => "DRIFTED",
            .in_sync => "IN_SYNC",
            .unknown => "UNKNOWN",
            .not_checked => "NOT_CHECKED",
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
