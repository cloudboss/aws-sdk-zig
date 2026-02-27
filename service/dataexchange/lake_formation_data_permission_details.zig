const LFTagPolicyDetails = @import("lf_tag_policy_details.zig").LFTagPolicyDetails;

/// Details about the AWS Lake Formation data permission.
pub const LakeFormationDataPermissionDetails = struct {
    /// Details about the LF-tag policy.
    lf_tag_policy: ?LFTagPolicyDetails,

    pub const json_field_names = .{
        .lf_tag_policy = "LFTagPolicy",
    };
};
