const aws = @import("aws");

const ResourceControlPolicyRestriction = @import("resource_control_policy_restriction.zig").ResourceControlPolicyRestriction;
const FindingSource = @import("finding_source.zig").FindingSource;

/// Contains information about an external access finding.
pub const ExternalAccessDetails = struct {
    /// The action in the analyzed policy statement that an external principal has
    /// permission to use.
    action: ?[]const []const u8,

    /// The condition in the analyzed policy statement that resulted in an external
    /// access finding.
    condition: []const aws.map.StringMapEntry,

    /// Specifies whether the external access finding is public.
    is_public: ?bool,

    /// The external principal that has access to a resource within the zone of
    /// trust.
    principal: ?[]const aws.map.StringMapEntry,

    /// The type of restriction applied to the finding by the resource owner with an
    /// Organizations resource control policy (RCP).
    ///
    /// * `APPLICABLE`: There is an RCP present in the organization but IAM Access
    ///   Analyzer does not include it in the evaluation of effective permissions.
    ///   For example, if `s3:DeleteObject` is blocked by the RCP and the
    ///   restriction is `APPLICABLE`, then `s3:DeleteObject` would still be
    ///   included in the list of actions for the finding.
    /// * `FAILED_TO_EVALUATE_RCP`: There was an error evaluating the RCP.
    /// * `NOT_APPLICABLE`: There was no RCP present in the organization, or there
    ///   was no RCP applicable to the resource. For example, the resource being
    ///   analyzed is an Amazon RDS snapshot and there is an RCP in the
    ///   organization, but the RCP only impacts Amazon S3 buckets.
    /// * `APPLIED`: This restriction is not currently available for external access
    ///   findings.
    resource_control_policy_restriction: ?ResourceControlPolicyRestriction,

    /// The sources of the external access finding. This indicates how the access
    /// that generated the finding is granted. It is populated for Amazon S3 bucket
    /// findings.
    sources: ?[]const FindingSource,

    pub const json_field_names = .{
        .action = "action",
        .condition = "condition",
        .is_public = "isPublic",
        .principal = "principal",
        .resource_control_policy_restriction = "resourceControlPolicyRestriction",
        .sources = "sources",
    };
};
