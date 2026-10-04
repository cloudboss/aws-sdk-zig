const std = @import("std");

pub const URLTargetConfiguration = enum {
    new_tab,
    new_window,
    same_tab,

    pub const json_field_names = .{
        .new_tab = "NEW_TAB",
        .new_window = "NEW_WINDOW",
        .same_tab = "SAME_TAB",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .new_tab => "NEW_TAB",
            .new_window => "NEW_WINDOW",
            .same_tab => "SAME_TAB",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
