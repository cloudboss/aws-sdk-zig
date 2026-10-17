const std = @import("std");

/// The category of application a pentest targets.
pub const TestScopeType = enum {
    /// A traditional web application.
    web_app,
    /// A generative AI application.
    generative_ai_app,

    pub const json_field_names = .{
        .web_app = "WEB_APP",
        .generative_ai_app = "GENERATIVE_AI_APP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .web_app => "WEB_APP",
            .generative_ai_app => "GENERATIVE_AI_APP",
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
