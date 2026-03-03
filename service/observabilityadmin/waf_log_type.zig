const std = @import("std");

/// Enumeration of supported WAF log types. Currently only WAF_LOGS is
/// supported.
pub const WAFLogType = enum {
    waf_logs,

    pub const json_field_names = .{
        .waf_logs = "WAF_LOGS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .waf_logs => "WAF_LOGS",
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
