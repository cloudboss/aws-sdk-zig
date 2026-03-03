const IndexSource = @import("index_source.zig").IndexSource;

/// This structure contains information about one field index policy in this
/// account.
pub const IndexPolicy = struct {
    /// The date and time that this index policy was most recently updated.
    last_update_time: ?i64 = null,

    /// The ARN of the log group that this index policy applies to.
    log_group_identifier: ?[]const u8 = null,

    /// The policy document for this index policy, in JSON format.
    policy_document: ?[]const u8 = null,

    /// The name of this policy. Responses about log group-level field index
    /// policies don't have
    /// this field, because those policies don't have names.
    policy_name: ?[]const u8 = null,

    /// This field indicates whether this is an account-level index policy or an
    /// index policy that
    /// applies only to a single log group.
    source: ?IndexSource = null,

    pub const json_field_names = .{
        .last_update_time = "lastUpdateTime",
        .log_group_identifier = "logGroupIdentifier",
        .policy_document = "policyDocument",
        .policy_name = "policyName",
        .source = "source",
    };
};
