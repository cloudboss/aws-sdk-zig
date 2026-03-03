const PolicyToPath = @import("policy_to_path.zig").PolicyToPath;

/// Represents the output of a LookupPolicy response operation.
pub const BatchLookupPolicyResponse = struct {
    /// The pagination token.
    next_token: ?[]const u8 = null,

    /// Provides list of path to policies. Policies contain `PolicyId`,
    /// `ObjectIdentifier`, and
    /// `PolicyType`. For more
    /// information, see
    /// [Policies](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/key_concepts_directory.html#key_concepts_policies).
    policy_to_path_list: ?[]const PolicyToPath = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .policy_to_path_list = "PolicyToPathList",
    };
};
