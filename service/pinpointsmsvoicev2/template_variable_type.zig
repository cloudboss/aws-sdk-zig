const std = @import("std");

/// The type of a template variable.
///
/// * `STRING` - String variable type.
/// * `INTEGER` - Integer variable type.
/// * `BOOLEAN` - Boolean variable type.
pub const TemplateVariableType = enum {
    string,
    integer,
    boolean,

    pub const json_field_names = .{
        .string = "STRING",
        .integer = "INTEGER",
        .boolean = "BOOLEAN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .string => "STRING",
            .integer => "INTEGER",
            .boolean => "BOOLEAN",
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
