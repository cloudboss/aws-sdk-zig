const std = @import("std");

pub const WindowsAccessAuditLogLevel = enum {
    disabled,
    success_only,
    failure_only,
    success_and_failure,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .success_only = "SUCCESS_ONLY",
        .failure_only = "FAILURE_ONLY",
        .success_and_failure = "SUCCESS_AND_FAILURE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disabled => "DISABLED",
            .success_only => "SUCCESS_ONLY",
            .failure_only => "FAILURE_ONLY",
            .success_and_failure => "SUCCESS_AND_FAILURE",
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
