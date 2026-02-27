const aws = @import("aws");

const AccountDetail = @import("account_detail.zig").AccountDetail;

pub const CreateMemberRequest = struct {
    /// The details of the account to associate with the administrator account.
    account: AccountDetail,

    /// A map of key-value pairs that specifies the tags to associate with the
    /// account in Amazon Macie.
    ///
    /// An account can have a maximum of 50 tags. Each tag consists of a tag key and
    /// an associated tag value. The maximum length of a tag key is 128 characters.
    /// The maximum length of a tag value is 256 characters.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .account = "account",
        .tags = "tags",
    };
};
