const std = @import("std");

/// Represents passthrough behavior for an integration response. Supported only
/// for WebSocket APIs.
pub const PassthroughBehavior = enum {
    when_no_match,
    never,
    when_no_templates,

    pub const json_field_names = .{
        .when_no_match = "WHEN_NO_MATCH",
        .never = "NEVER",
        .when_no_templates = "WHEN_NO_TEMPLATES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .when_no_match => "WHEN_NO_MATCH",
            .never => "NEVER",
            .when_no_templates => "WHEN_NO_TEMPLATES",
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
