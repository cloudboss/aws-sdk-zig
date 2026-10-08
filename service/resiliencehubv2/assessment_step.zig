const std = @import("std");

pub const AssessmentStep = enum {
    topology_generation,
    input_validation,
    design_analysis,
    topology_enhancement,
    service_function_generation,
    policy_validation,
    resilience_assessment,
    failure_mode_findings_consolidation,
    failure_mode_findings_enrichment,

    pub const json_field_names = .{
        .topology_generation = "TOPOLOGY_GENERATION",
        .input_validation = "INPUT_VALIDATION",
        .design_analysis = "DESIGN_ANALYSIS",
        .topology_enhancement = "TOPOLOGY_ENHANCEMENT",
        .service_function_generation = "SERVICE_FUNCTION_GENERATION",
        .policy_validation = "POLICY_VALIDATION",
        .resilience_assessment = "RESILIENCE_ASSESSMENT",
        .failure_mode_findings_consolidation = "FAILURE_MODE_FINDINGS_CONSOLIDATION",
        .failure_mode_findings_enrichment = "FAILURE_MODE_FINDINGS_ENRICHMENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .topology_generation => "TOPOLOGY_GENERATION",
            .input_validation => "INPUT_VALIDATION",
            .design_analysis => "DESIGN_ANALYSIS",
            .topology_enhancement => "TOPOLOGY_ENHANCEMENT",
            .service_function_generation => "SERVICE_FUNCTION_GENERATION",
            .policy_validation => "POLICY_VALIDATION",
            .resilience_assessment => "RESILIENCE_ASSESSMENT",
            .failure_mode_findings_consolidation => "FAILURE_MODE_FINDINGS_CONSOLIDATION",
            .failure_mode_findings_enrichment => "FAILURE_MODE_FINDINGS_ENRICHMENT",
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
