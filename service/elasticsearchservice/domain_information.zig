pub const DomainInformation = struct {
    domain_name: []const u8,

    owner_id: ?[]const u8 = null,

    region: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .owner_id = "OwnerId",
        .region = "Region",
    };
};
