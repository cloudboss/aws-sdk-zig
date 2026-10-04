const std = @import("std");

/// The programming language of the instrumentation point. Java, Python, and
/// JavaScript are currently supported.
pub const ProgrammingLanguage = enum {
    java,
    python,
    javascript,

    pub const json_field_names = .{
        .java = "Java",
        .python = "Python",
        .javascript = "Javascript",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .java => "Java",
            .python => "Python",
            .javascript => "Javascript",
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
