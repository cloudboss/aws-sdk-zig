const std = @import("std");

pub const SourceType = enum {
    aws_bedrock_agentcore_runtime,
    aws_bedrock_agentcore_gateway,

    pub const json_field_names = .{
        .aws_bedrock_agentcore_runtime = "AWS::BedrockAgentCore::Runtime",
        .aws_bedrock_agentcore_gateway = "AWS::BedrockAgentCore::Gateway",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_bedrock_agentcore_runtime => "AWS::BedrockAgentCore::Runtime",
            .aws_bedrock_agentcore_gateway => "AWS::BedrockAgentCore::Gateway",
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
