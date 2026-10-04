const std = @import("std");

pub const JobCategory = enum {
    agent_rft,
    agent_rft_evaluation,

    pub const json_field_names = .{
        .agent_rft = "AgentRFT",
        .agent_rft_evaluation = "AgentRFTEvaluation",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .agent_rft => "AgentRFT",
            .agent_rft_evaluation => "AgentRFTEvaluation",
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
