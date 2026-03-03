/// Information about the Detective administrator account for an
/// organization.
pub const Administrator = struct {
    /// The Amazon Web Services account identifier of the Detective administrator
    /// account for the organization.
    account_id: ?[]const u8 = null,

    /// The date and time when the Detective administrator account was enabled. The
    /// value is an ISO8601 formatted string. For example,
    /// `2021-08-18T16:35:56.284Z`.
    delegation_time: ?i64 = null,

    /// The ARN of the organization behavior graph.
    graph_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .delegation_time = "DelegationTime",
        .graph_arn = "GraphArn",
    };
};
