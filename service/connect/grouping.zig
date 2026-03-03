const std = @import("std");

pub const Grouping = enum {
    queue,
    channel,
    routing_profile,
    routing_step_expression,
    agent_status,
    subtype,
    validation_test_type,

    pub const json_field_names = .{
        .queue = "QUEUE",
        .channel = "CHANNEL",
        .routing_profile = "ROUTING_PROFILE",
        .routing_step_expression = "ROUTING_STEP_EXPRESSION",
        .agent_status = "AGENT_STATUS",
        .subtype = "SUBTYPE",
        .validation_test_type = "VALIDATION_TEST_TYPE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .queue => "QUEUE",
            .channel => "CHANNEL",
            .routing_profile => "ROUTING_PROFILE",
            .routing_step_expression => "ROUTING_STEP_EXPRESSION",
            .agent_status => "AGENT_STATUS",
            .subtype => "SUBTYPE",
            .validation_test_type => "VALIDATION_TEST_TYPE",
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
