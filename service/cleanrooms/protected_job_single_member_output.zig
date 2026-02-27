/// Details about the member who received the job result.
pub const ProtectedJobSingleMemberOutput = struct {
    /// The Amazon Web Services account ID of the member in the collaboration who
    /// can receive results from analyses.
    account_id: []const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
    };
};
