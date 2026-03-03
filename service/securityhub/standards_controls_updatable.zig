const std = @import("std");

pub const StandardsControlsUpdatable = enum {
    ready_for_updates,
    not_ready_for_updates,

    pub const json_field_names = .{
        .ready_for_updates = "READY_FOR_UPDATES",
        .not_ready_for_updates = "NOT_READY_FOR_UPDATES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ready_for_updates => "READY_FOR_UPDATES",
            .not_ready_for_updates => "NOT_READY_FOR_UPDATES",
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
