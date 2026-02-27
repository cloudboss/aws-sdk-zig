/// Details new user agents used either at the resource or account level.
pub const NewUserAgentDetail = struct {
    /// Checks if the user agent is new for the entire account.
    is_new_for_entire_account: bool = false,

    /// New user agent which accessed the resource.
    user_agent: ?[]const u8,

    pub const json_field_names = .{
        .is_new_for_entire_account = "IsNewForEntireAccount",
        .user_agent = "UserAgent",
    };
};
