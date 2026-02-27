const ValidatePolicyFindingType = @import("validate_policy_finding_type.zig").ValidatePolicyFindingType;
const Location = @import("location.zig").Location;

/// A finding in a policy. Each finding is an actionable recommendation that can
/// be used to improve the policy.
pub const ValidatePolicyFinding = struct {
    /// A localized message that explains the finding and provides guidance on how
    /// to address it.
    finding_details: []const u8,

    /// The impact of the finding.
    ///
    /// Security warnings report when the policy allows access that we consider
    /// overly permissive.
    ///
    /// Errors report when a part of the policy is not functional.
    ///
    /// Warnings report non-security issues when a policy does not conform to policy
    /// writing best practices.
    ///
    /// Suggestions recommend stylistic improvements in the policy that do not
    /// impact access.
    finding_type: ValidatePolicyFindingType,

    /// The issue code provides an identifier of the issue associated with this
    /// finding.
    issue_code: []const u8,

    /// A link to additional documentation about the type of finding.
    learn_more_link: []const u8,

    /// The list of locations in the policy document that are related to the
    /// finding. The issue code provides a summary of an issue identified by the
    /// finding.
    locations: []const Location,

    pub const json_field_names = .{
        .finding_details = "findingDetails",
        .finding_type = "findingType",
        .issue_code = "issueCode",
        .learn_more_link = "learnMoreLink",
        .locations = "locations",
    };
};
