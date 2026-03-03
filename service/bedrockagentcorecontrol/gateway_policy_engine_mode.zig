const std = @import("std");

pub const GatewayPolicyEngineMode = enum {
    log_only,
    enforce,

    pub const json_field_names = .{
        .log_only = "LOG_ONLY",
        .enforce = "ENFORCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .log_only => "LOG_ONLY",
            .enforce => "ENFORCE",
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
