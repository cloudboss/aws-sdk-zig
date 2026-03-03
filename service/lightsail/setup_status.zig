const std = @import("std");

pub const SetupStatus = enum {
    succeeded,
    failed,
    in_progress,

    pub const json_field_names = .{
        .succeeded = "succeeded",
        .failed = "failed",
        .in_progress = "inProgress",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .succeeded => "succeeded",
            .failed => "failed",
            .in_progress => "inProgress",
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
