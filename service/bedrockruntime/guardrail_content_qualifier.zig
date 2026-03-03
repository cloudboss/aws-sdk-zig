const std = @import("std");

pub const GuardrailContentQualifier = enum {
    grounding_source,
    query,
    guard_content,

    pub const json_field_names = .{
        .grounding_source = "grounding_source",
        .query = "query",
        .guard_content = "guard_content",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .grounding_source => "grounding_source",
            .query => "query",
            .guard_content => "guard_content",
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
