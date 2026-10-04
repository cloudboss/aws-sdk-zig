const std = @import("std");

pub const ResourcesNumberField = enum {
    total_findings,
    severity_other,
    severity_fatal,
    severity_critical,
    severity_high,
    severity_medium,
    severity_low,
    severity_informational,
    severity_unknown,
    self_hosted_ai_model_resource_count,
    self_hosted_ai_agent_resource_count,
    self_hosted_ai_model_serving_resource_count,
    self_hosted_ai_external_endpoint_resource_count,
    self_hosted_ai_development_resource_count,
    self_hosted_ai_agent_framework_resource_count,
    self_hosted_ai_agent_tools_and_identity_resource_count,
    self_hosted_total_ai_resource_count,

    pub const json_field_names = .{
        .total_findings = "FindingsSummary.TotalFindings",
        .severity_other = "FindingsSummary.Severities.Other",
        .severity_fatal = "FindingsSummary.Severities.Fatal",
        .severity_critical = "FindingsSummary.Severities.Critical",
        .severity_high = "FindingsSummary.Severities.High",
        .severity_medium = "FindingsSummary.Severities.Medium",
        .severity_low = "FindingsSummary.Severities.Low",
        .severity_informational = "FindingsSummary.Severities.Informational",
        .severity_unknown = "FindingsSummary.Severities.Unknown",
        .self_hosted_ai_model_resource_count = "ResourceInfo.AIDetails.SelfHostedAIModelResourceCount",
        .self_hosted_ai_agent_resource_count = "ResourceInfo.AIDetails.SelfHostedAIAgentResourceCount",
        .self_hosted_ai_model_serving_resource_count = "ResourceInfo.AIDetails.SelfHostedAIModelServingResourceCount",
        .self_hosted_ai_external_endpoint_resource_count = "ResourceInfo.AIDetails.SelfHostedAIExternalEndpointResourceCount",
        .self_hosted_ai_development_resource_count = "ResourceInfo.AIDetails.SelfHostedAIDevelopmentResourceCount",
        .self_hosted_ai_agent_framework_resource_count = "ResourceInfo.AIDetails.SelfHostedAIAgentFrameworkResourceCount",
        .self_hosted_ai_agent_tools_and_identity_resource_count = "ResourceInfo.AIDetails.SelfHostedAIAgentToolsAndIdentityResourceCount",
        .self_hosted_total_ai_resource_count = "ResourceInfo.AIDetails.SelfHostedTotalAIResourceCount",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .total_findings => "FindingsSummary.TotalFindings",
            .severity_other => "FindingsSummary.Severities.Other",
            .severity_fatal => "FindingsSummary.Severities.Fatal",
            .severity_critical => "FindingsSummary.Severities.Critical",
            .severity_high => "FindingsSummary.Severities.High",
            .severity_medium => "FindingsSummary.Severities.Medium",
            .severity_low => "FindingsSummary.Severities.Low",
            .severity_informational => "FindingsSummary.Severities.Informational",
            .severity_unknown => "FindingsSummary.Severities.Unknown",
            .self_hosted_ai_model_resource_count => "ResourceInfo.AIDetails.SelfHostedAIModelResourceCount",
            .self_hosted_ai_agent_resource_count => "ResourceInfo.AIDetails.SelfHostedAIAgentResourceCount",
            .self_hosted_ai_model_serving_resource_count => "ResourceInfo.AIDetails.SelfHostedAIModelServingResourceCount",
            .self_hosted_ai_external_endpoint_resource_count => "ResourceInfo.AIDetails.SelfHostedAIExternalEndpointResourceCount",
            .self_hosted_ai_development_resource_count => "ResourceInfo.AIDetails.SelfHostedAIDevelopmentResourceCount",
            .self_hosted_ai_agent_framework_resource_count => "ResourceInfo.AIDetails.SelfHostedAIAgentFrameworkResourceCount",
            .self_hosted_ai_agent_tools_and_identity_resource_count => "ResourceInfo.AIDetails.SelfHostedAIAgentToolsAndIdentityResourceCount",
            .self_hosted_total_ai_resource_count => "ResourceInfo.AIDetails.SelfHostedTotalAIResourceCount",
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
