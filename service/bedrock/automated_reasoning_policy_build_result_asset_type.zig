const std = @import("std");

pub const AutomatedReasoningPolicyBuildResultAssetType = enum {
    build_log,
    quality_report,
    policy_definition,
    generated_test_cases,
    policy_scenarios,
    fidelity_report,
    asset_manifest,
    source_document,

    pub const json_field_names = .{
        .build_log = "BUILD_LOG",
        .quality_report = "QUALITY_REPORT",
        .policy_definition = "POLICY_DEFINITION",
        .generated_test_cases = "GENERATED_TEST_CASES",
        .policy_scenarios = "POLICY_SCENARIOS",
        .fidelity_report = "FIDELITY_REPORT",
        .asset_manifest = "ASSET_MANIFEST",
        .source_document = "SOURCE_DOCUMENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .build_log => "BUILD_LOG",
            .quality_report => "QUALITY_REPORT",
            .policy_definition => "POLICY_DEFINITION",
            .generated_test_cases => "GENERATED_TEST_CASES",
            .policy_scenarios => "POLICY_SCENARIOS",
            .fidelity_report => "FIDELITY_REPORT",
            .asset_manifest => "ASSET_MANIFEST",
            .source_document => "SOURCE_DOCUMENT",
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
