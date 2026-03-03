const std = @import("std");

/// The access method to use when retrieving occurrences of sensitive data
/// reported by findings. Valid values are:
pub const RetrievalMode = enum {
    caller_credentials,
    assume_role,

    pub const json_field_names = .{
        .caller_credentials = "CALLER_CREDENTIALS",
        .assume_role = "ASSUME_ROLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .caller_credentials => "CALLER_CREDENTIALS",
            .assume_role => "ASSUME_ROLE",
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
