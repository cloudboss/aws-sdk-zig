const std = @import("std");

/// Provides context for the cause of the bad request. The only supported value
/// is
/// `CODE_ERROR`.
pub const BadRequestReason = enum {
    code_error,

    pub const json_field_names = .{
        .code_error = "CODE_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .code_error => "CODE_ERROR",
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
