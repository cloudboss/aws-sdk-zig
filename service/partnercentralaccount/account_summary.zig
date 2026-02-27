/// Summary information about an AWS account.
pub const AccountSummary = struct {
    /// The name associated with the AWS account.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};
