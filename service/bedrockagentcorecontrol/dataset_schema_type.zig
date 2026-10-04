const std = @import("std");

/// Versioned schema type for dataset examples. Each value identifies both the
/// source format and the version of that format's schema.
pub const DatasetSchemaType = enum {
    /// AgentCore predefined evaluation schema, version 1. Dataset with pre-written
    /// inputs per conversation turn.
    agentcore_evaluation_predefined_v1,
    /// AgentCore simulated evaluation schema, version 1. Dataset for synthetic data
    /// generation where each example is a scenario used to generate full
    /// conversations.
    agentcore_evaluation_simulated_v1,
    /// Third-party evaluation schema, version 1. Supports single-turn (string
    /// input) and multi-turn (message list input) across third-party evaluation
    /// frameworks.
    third_party_evaluation_v1,

    pub const json_field_names = .{
        .agentcore_evaluation_predefined_v1 = "AGENTCORE_EVALUATION_PREDEFINED_V1",
        .agentcore_evaluation_simulated_v1 = "AGENTCORE_EVALUATION_SIMULATED_V1",
        .third_party_evaluation_v1 = "THIRD_PARTY_EVALUATION_V1",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .agentcore_evaluation_predefined_v1 => "AGENTCORE_EVALUATION_PREDEFINED_V1",
            .agentcore_evaluation_simulated_v1 => "AGENTCORE_EVALUATION_SIMULATED_V1",
            .third_party_evaluation_v1 => "THIRD_PARTY_EVALUATION_V1",
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
