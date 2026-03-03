const std = @import("std");

/// Global Configuration Input End Action
pub const GlobalConfigurationInputEndAction = enum {
    none,
    switch_and_loop_inputs,

    pub const json_field_names = .{
        .none = "NONE",
        .switch_and_loop_inputs = "SWITCH_AND_LOOP_INPUTS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .switch_and_loop_inputs => "SWITCH_AND_LOOP_INPUTS",
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
