/// Contains details about the remote Amazon Web Services account that made the
/// API call.
pub const RemoteAccountDetails = struct {
    /// The Amazon Web Services account ID of the remote API caller.
    account_id: ?[]const u8 = null,

    /// Details on whether the Amazon Web Services account of the remote API caller
    /// is related to your GuardDuty environment. If this value is `True` the API
    /// caller is affiliated to your account in some way. If it is `False` the API
    /// caller is from outside your environment.
    affiliated: ?bool = null,

    /// If the remote account belongs to an Amazon Web Services service, this field
    /// indicates which service the remote account belongs to.
    aws_service_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .affiliated = "Affiliated",
        .aws_service_name = "AwsServiceName",
    };
};
