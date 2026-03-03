const std = @import("std");

pub const RunType = enum {
    canary_run,
    dry_run,

    pub const json_field_names = .{
        .canary_run = "CANARY_RUN",
        .dry_run = "DRY_RUN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .canary_run => "CANARY_RUN",
            .dry_run => "DRY_RUN",
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
