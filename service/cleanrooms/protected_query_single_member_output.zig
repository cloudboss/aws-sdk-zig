/// Details about the member who received the query result.
pub const ProtectedQuerySingleMemberOutput = struct {
    /// The Amazon Web Services account ID of the member in the collaboration who
    /// can receive results for the query.
    account_id: []const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
    };
};
