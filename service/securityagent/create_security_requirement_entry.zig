/// Contains the details for a security requirement to create within a pack.
pub const CreateSecurityRequirementEntry = struct {
    /// A description of the security requirement.
    description: []const u8,

    /// The security domain the requirement belongs to.
    domain: []const u8,

    /// The evaluation criteria used to assess compliance with this requirement.
    evaluation: []const u8,

    /// The name of the security requirement.
    name: []const u8,

    /// The recommended remediation steps when the requirement is not met.
    remediation: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .domain = "domain",
        .evaluation = "evaluation",
        .name = "name",
        .remediation = "remediation",
    };
};
