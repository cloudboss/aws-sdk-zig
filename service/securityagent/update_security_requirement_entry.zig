/// Contains the details for updating an existing security requirement within a
/// pack. The name is an immutable identifier used to locate the requirement and
/// cannot be modified.
pub const UpdateSecurityRequirementEntry = struct {
    /// The updated description of the security requirement.
    description: ?[]const u8 = null,

    /// The updated security domain the requirement belongs to.
    domain: ?[]const u8 = null,

    /// The updated evaluation criteria used to assess compliance with this
    /// requirement.
    evaluation: ?[]const u8 = null,

    /// The name of the security requirement to update. This is an immutable
    /// identifier and cannot be changed once the requirement is created.
    name: []const u8,

    /// The updated remediation steps when the requirement is not met.
    remediation: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .domain = "domain",
        .evaluation = "evaluation",
        .name = "name",
        .remediation = "remediation",
    };
};
