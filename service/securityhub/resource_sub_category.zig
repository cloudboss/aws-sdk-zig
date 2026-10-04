const std = @import("std");

pub const ResourceSubCategory = enum {
    model,
    model_serving,
    agent,
    agent_framework,
    agent_tools_and_identity,
    safety_and_guardrail,
    knowledge_and_data,
    orchestration_and_pipeline,
    external_endpoint,
    development,
    other,

    pub const json_field_names = .{
        .model = "Model",
        .model_serving = "ModelServing",
        .agent = "Agent",
        .agent_framework = "AgentFramework",
        .agent_tools_and_identity = "AgentToolsAndIdentity",
        .safety_and_guardrail = "SafetyAndGuardrail",
        .knowledge_and_data = "KnowledgeAndData",
        .orchestration_and_pipeline = "OrchestrationAndPipeline",
        .external_endpoint = "ExternalEndpoint",
        .development = "Development",
        .other = "Other",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .model => "Model",
            .model_serving => "ModelServing",
            .agent => "Agent",
            .agent_framework => "AgentFramework",
            .agent_tools_and_identity => "AgentToolsAndIdentity",
            .safety_and_guardrail => "SafetyAndGuardrail",
            .knowledge_and_data => "KnowledgeAndData",
            .orchestration_and_pipeline => "OrchestrationAndPipeline",
            .external_endpoint => "ExternalEndpoint",
            .development => "Development",
            .other => "Other",
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
