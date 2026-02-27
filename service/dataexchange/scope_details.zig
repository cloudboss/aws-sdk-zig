const LakeFormationTagPolicyDetails = @import("lake_formation_tag_policy_details.zig").LakeFormationTagPolicyDetails;
const RedshiftDataShareDetails = @import("redshift_data_share_details.zig").RedshiftDataShareDetails;
const S3DataAccessDetails = @import("s3_data_access_details.zig").S3DataAccessDetails;

/// Details about the scope of the notifications such as the affected resources.
pub const ScopeDetails = struct {
    /// Underlying
    /// LF resources that will be affected by this notification.
    lake_formation_tag_policies: ?[]const LakeFormationTagPolicyDetails,

    /// Underlying
    /// Redshift resources that will be affected by this notification.
    redshift_data_shares: ?[]const RedshiftDataShareDetails,

    /// Underlying
    /// S3 resources that will be affected by this notification.
    s3_data_accesses: ?[]const S3DataAccessDetails,

    pub const json_field_names = .{
        .lake_formation_tag_policies = "LakeFormationTagPolicies",
        .redshift_data_shares = "RedshiftDataShares",
        .s3_data_accesses = "S3DataAccesses",
    };
};
