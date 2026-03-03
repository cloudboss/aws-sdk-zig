pub const ServiceId = struct {
    account_id: ?[]const u8 = null,

    name: ?[]const u8 = null,

    names: ?[]const []const u8 = null,

    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .name = "Name",
        .names = "Names",
        .@"type" = "Type",
    };
};
