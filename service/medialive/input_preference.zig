const std = @import("std");

/// Input preference when deciding which input to make active when a previously
/// failed input has recovered.
/// If \"EQUAL_INPUT_PREFERENCE\", then the active input will stay active as
/// long as it is healthy.
/// If \"PRIMARY_INPUT_PREFERRED\", then always switch back to the primary input
/// when it is healthy.
pub const InputPreference = enum {
    equal_input_preference,
    primary_input_preferred,

    pub const json_field_names = .{
        .equal_input_preference = "EQUAL_INPUT_PREFERENCE",
        .primary_input_preferred = "PRIMARY_INPUT_PREFERRED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .equal_input_preference => "EQUAL_INPUT_PREFERENCE",
            .primary_input_preferred => "PRIMARY_INPUT_PREFERRED",
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
