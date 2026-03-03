const std = @import("std");

pub const FlowNodeInputCategory = enum {
    loop_condition,
    return_value_to_loop_start,
    exit_loop,

    pub const json_field_names = .{
        .loop_condition = "LoopCondition",
        .return_value_to_loop_start = "ReturnValueToLoopStart",
        .exit_loop = "ExitLoop",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .loop_condition => "LoopCondition",
            .return_value_to_loop_start => "ReturnValueToLoopStart",
            .exit_loop => "ExitLoop",
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
