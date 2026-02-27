/// The identity type of the requester that calls the API operation.
pub const UserIdentityType = enum {
    awsaccount,
    awsservice,

    pub const json_field_names = .{
        .awsaccount = "AWSACCOUNT",
        .awsservice = "AWSSERVICE",
    };
};
