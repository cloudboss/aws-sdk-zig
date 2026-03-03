const std = @import("std");

pub const ActionsMode = enum {
    skip_all,
    run_all,

    pub const json_field_names = .{
        .skip_all = "skip-all",
        .run_all = "run-all",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .skip_all => "skip-all",
            .run_all => "run-all",
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
