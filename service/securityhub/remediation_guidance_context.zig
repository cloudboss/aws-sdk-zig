/// The context behind the remediation target's existence and guidance.
pub const RemediationGuidanceContext = struct {
    /// The scope of the resources affected by the resolution of the remediation
    /// target.
    affected_scope: ?[]const u8 = null,

    /// An array of prerequisite steps in resolving the remediation target.
    prerequisites: ?[]const []const u8 = null,

    /// Explains the cause which directly created the remediation target.
    problem_statement: ?[]const u8 = null,

    /// An assessment of the existing risk the remediation target creates.
    risk_assessment: ?[]const u8 = null,

    pub const json_field_names = .{
        .affected_scope = "AffectedScope",
        .prerequisites = "Prerequisites",
        .problem_statement = "ProblemStatement",
        .risk_assessment = "RiskAssessment",
    };
};
