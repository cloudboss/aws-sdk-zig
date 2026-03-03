const std = @import("std");

pub const FlowStatus = enum {
    failed,
    prepared,
    preparing,
    not_prepared,

    pub const json_field_names = .{
        .failed = "Failed",
        .prepared = "Prepared",
        .preparing = "Preparing",
        .not_prepared = "NotPrepared",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .failed => "Failed",
            .prepared => "Prepared",
            .preparing => "Preparing",
            .not_prepared => "NotPrepared",
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
