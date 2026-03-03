const std = @import("std");

pub const OptInType = enum {
    immediate,
    next_maintenance,
    apply_on,
    undo_opt_in,

    pub const json_field_names = .{
        .immediate = "IMMEDIATE",
        .next_maintenance = "NEXT_MAINTENANCE",
        .apply_on = "APPLY_ON",
        .undo_opt_in = "UNDO_OPT_IN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .immediate => "IMMEDIATE",
            .next_maintenance => "NEXT_MAINTENANCE",
            .apply_on => "APPLY_ON",
            .undo_opt_in => "UNDO_OPT_IN",
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
