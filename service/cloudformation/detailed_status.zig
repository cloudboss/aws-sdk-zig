const std = @import("std");

pub const DetailedStatus = enum {
    configuration_complete,
    validation_failed,

    pub const json_field_names = .{
        .configuration_complete = "CONFIGURATION_COMPLETE",
        .validation_failed = "VALIDATION_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .configuration_complete => "CONFIGURATION_COMPLETE",
            .validation_failed => "VALIDATION_FAILED",
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
