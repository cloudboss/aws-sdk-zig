const std = @import("std");

pub const FailureReason = enum {
    request_timed_out,
    unsupported_algorithm,
    other,

    pub const json_field_names = .{
        .request_timed_out = "REQUEST_TIMED_OUT",
        .unsupported_algorithm = "UNSUPPORTED_ALGORITHM",
        .other = "OTHER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .request_timed_out => "REQUEST_TIMED_OUT",
            .unsupported_algorithm => "UNSUPPORTED_ALGORITHM",
            .other => "OTHER",
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
