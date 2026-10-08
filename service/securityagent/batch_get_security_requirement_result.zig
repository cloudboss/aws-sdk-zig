/// Contains information about a successfully retrieved security requirement.
pub const BatchGetSecurityRequirementResult = struct {
    /// The date and time the security requirement was created, in UTC format.
    created_at: i64,

    /// A description of the security requirement.
    description: []const u8,

    /// The security domain the requirement belongs to.
    domain: []const u8,

    /// The evaluation criteria used to assess compliance with this requirement.
    evaluation: []const u8,

    /// The name of the security requirement.
    name: []const u8,

    /// The unique identifier of the pack containing the security requirement.
    pack_id: []const u8,

    /// The recommended remediation steps when the requirement is not met.
    remediation: ?[]const u8 = null,

    /// The date and time the security requirement was last updated, in UTC format.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .domain = "domain",
        .evaluation = "evaluation",
        .name = "name",
        .pack_id = "packId",
        .remediation = "remediation",
        .updated_at = "updatedAt",
    };
};
