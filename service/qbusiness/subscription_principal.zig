/// A user or group in the IAM Identity Center instance connected to the Amazon
/// Q Business application.
pub const SubscriptionPrincipal = union(enum) {
    /// The identifier of a group in the IAM Identity Center instance connected to
    /// the Amazon Q Business application.
    group: ?[]const u8,
    /// The identifier of a user in the IAM Identity Center instance connected to
    /// the Amazon Q Business application.
    user: ?[]const u8,

    pub const json_field_names = .{
        .group = "group",
        .user = "user",
    };
};
