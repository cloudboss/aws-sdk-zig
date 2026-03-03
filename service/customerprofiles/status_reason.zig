const std = @import("std");

pub const StatusReason = enum {
    validation_failure,
    internal_failure,

    pub const json_field_names = .{
        .validation_failure = "VALIDATION_FAILURE",
        .internal_failure = "INTERNAL_FAILURE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .validation_failure => "VALIDATION_FAILURE",
            .internal_failure => "INTERNAL_FAILURE",
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
