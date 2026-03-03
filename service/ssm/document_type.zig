const std = @import("std");

pub const DocumentType = enum {
    command,
    policy,
    automation,
    session,
    package,
    application_configuration,
    application_configuration_schema,
    deployment_strategy,
    change_calendar,
    change_template,
    problem_analysis,
    problem_analysis_template,
    cloud_formation,
    conformance_pack_template,
    quick_setup,
    manual_approval_policy,
    auto_approval_policy,

    pub const json_field_names = .{
        .command = "Command",
        .policy = "Policy",
        .automation = "Automation",
        .session = "Session",
        .package = "Package",
        .application_configuration = "ApplicationConfiguration",
        .application_configuration_schema = "ApplicationConfigurationSchema",
        .deployment_strategy = "DeploymentStrategy",
        .change_calendar = "ChangeCalendar",
        .change_template = "Automation.ChangeTemplate",
        .problem_analysis = "ProblemAnalysis",
        .problem_analysis_template = "ProblemAnalysisTemplate",
        .cloud_formation = "CloudFormation",
        .conformance_pack_template = "ConformancePackTemplate",
        .quick_setup = "QuickSetup",
        .manual_approval_policy = "ManualApprovalPolicy",
        .auto_approval_policy = "AutoApprovalPolicy",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .command => "Command",
            .policy => "Policy",
            .automation => "Automation",
            .session => "Session",
            .package => "Package",
            .application_configuration => "ApplicationConfiguration",
            .application_configuration_schema => "ApplicationConfigurationSchema",
            .deployment_strategy => "DeploymentStrategy",
            .change_calendar => "ChangeCalendar",
            .change_template => "Automation.ChangeTemplate",
            .problem_analysis => "ProblemAnalysis",
            .problem_analysis_template => "ProblemAnalysisTemplate",
            .cloud_formation => "CloudFormation",
            .conformance_pack_template => "ConformancePackTemplate",
            .quick_setup => "QuickSetup",
            .manual_approval_policy => "ManualApprovalPolicy",
            .auto_approval_policy => "AutoApprovalPolicy",
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
