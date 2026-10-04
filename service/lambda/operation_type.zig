const std = @import("std");

pub const OperationType = enum {
    execution,
    context,
    step,
    wait,
    callback,
    chained_invoke,

    pub const json_field_names = .{
        .execution = "EXECUTION",
        .context = "CONTEXT",
        .step = "STEP",
        .wait = "WAIT",
        .callback = "CALLBACK",
        .chained_invoke = "CHAINED_INVOKE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .execution => "EXECUTION",
            .context => "CONTEXT",
            .step => "STEP",
            .wait => "WAIT",
            .callback => "CALLBACK",
            .chained_invoke => "CHAINED_INVOKE",
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
