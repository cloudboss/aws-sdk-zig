const std = @import("std");

pub const ServerErrorCategory = enum {
    connectivity_error,
    credential_error,
    permission_error,
    architecture_error,
    other_error,

    pub const json_field_names = .{
        .connectivity_error = "CONNECTIVITY_ERROR",
        .credential_error = "CREDENTIAL_ERROR",
        .permission_error = "PERMISSION_ERROR",
        .architecture_error = "ARCHITECTURE_ERROR",
        .other_error = "OTHER_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .connectivity_error => "CONNECTIVITY_ERROR",
            .credential_error => "CREDENTIAL_ERROR",
            .permission_error => "PERMISSION_ERROR",
            .architecture_error => "ARCHITECTURE_ERROR",
            .other_error => "OTHER_ERROR",
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
