const std = @import("std");

pub const AutomatedReasoningPolicyBuildWorkflowType = enum {
    ingest_content,
    refine_policy,
    import_policy,
    generate_fidelity_report,
    generate_policy_scenarios,
    resolve_policy_ambiguities,
    iteratively_refine_policy,

    pub const json_field_names = .{
        .ingest_content = "INGEST_CONTENT",
        .refine_policy = "REFINE_POLICY",
        .import_policy = "IMPORT_POLICY",
        .generate_fidelity_report = "GENERATE_FIDELITY_REPORT",
        .generate_policy_scenarios = "GENERATE_POLICY_SCENARIOS",
        .resolve_policy_ambiguities = "RESOLVE_POLICY_AMBIGUITIES",
        .iteratively_refine_policy = "ITERATIVELY_REFINE_POLICY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ingest_content => "INGEST_CONTENT",
            .refine_policy => "REFINE_POLICY",
            .import_policy => "IMPORT_POLICY",
            .generate_fidelity_report => "GENERATE_FIDELITY_REPORT",
            .generate_policy_scenarios => "GENERATE_POLICY_SCENARIOS",
            .resolve_policy_ambiguities => "RESOLVE_POLICY_AMBIGUITIES",
            .iteratively_refine_policy => "ITERATIVELY_REFINE_POLICY",
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
