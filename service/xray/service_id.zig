pub const ServiceId = struct {
    account_id: ?[]const u8,

    name: ?[]const u8,

    names: ?[]const []const u8,

    @"type": ?[]const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .name = "Name",
        .names = "Names",
        .@"type" = "Type",
    };
};
