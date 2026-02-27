/// Resource Owner
pub const ResourceOwner = enum {
    service,
    account,

    pub const json_field_names = .{
        .service = "SERVICE",
        .account = "ACCOUNT",
    };
};
