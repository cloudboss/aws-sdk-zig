/// The target of a mitigation action task.
pub const DetectMitigationActionsTaskTarget = struct {
    /// The name of the behavior.
    behavior_name: ?[]const u8 = null,

    /// The name of the security profile.
    security_profile_name: ?[]const u8 = null,

    /// The unique identifiers of the violations.
    violation_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .behavior_name = "behaviorName",
        .security_profile_name = "securityProfileName",
        .violation_ids = "violationIds",
    };
};
