const std = @import("std");

/// An enumerated type that determines how the evaluated rules are processed.
/// RuleType can be one of the following:
///
/// ATLEAST - At least N routing controls must be set. You specify N as the
/// Threshold in the rule configuration.
///
/// AND - All routing controls must be set. This is a shortcut for "At least N,"
/// where N is the total number of controls in the rule.
///
/// OR - Any control must be set. This is a shortcut for "At least N," where N
/// is 1.
pub const RuleType = enum {
    atleast,
    @"and",
    @"or",

    pub const json_field_names = .{
        .atleast = "ATLEAST",
        .@"and" = "AND",
        .@"or" = "OR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .atleast => "ATLEAST",
            .@"and" => "AND",
            .@"or" => "OR",
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
