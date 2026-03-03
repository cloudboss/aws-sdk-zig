/// A structure that describes a filter for account assignments.
pub const ListAccountAssignmentsFilter = struct {
    /// The ID number of an Amazon Web Services account that filters the results in
    /// the response.
    account_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
    };
};
