const std = @import("std");

pub const MaintenanceWindowTaskType = enum {
    run_command,
    automation,
    step_functions,
    lambda,

    pub const json_field_names = .{
        .run_command = "RUN_COMMAND",
        .automation = "AUTOMATION",
        .step_functions = "STEP_FUNCTIONS",
        .lambda = "LAMBDA",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .run_command => "RUN_COMMAND",
            .automation => "AUTOMATION",
            .step_functions => "STEP_FUNCTIONS",
            .lambda => "LAMBDA",
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
