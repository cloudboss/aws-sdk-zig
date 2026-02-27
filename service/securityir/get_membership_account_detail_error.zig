pub const GetMembershipAccountDetailError = struct {
    account_id: []const u8,

    @"error": []const u8,

    message: []const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .@"error" = "error",
        .message = "message",
    };
};
