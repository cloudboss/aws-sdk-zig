/// Contains details about the remote Amazon Web Services account that made the
/// API call.
pub const RemoteAccountDetails = struct {
    /// The Amazon Web Services account ID of the remote API caller.
    account_id: ?[]const u8,

    /// Details on whether the Amazon Web Services account of the remote API caller
    /// is related to your GuardDuty
    /// environment. If this value is `True` the API caller is affiliated to your
    /// account
    /// in some way. If it is `False` the API caller is from outside your
    /// environment.
    affiliated: ?bool,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .affiliated = "Affiliated",
    };
};
