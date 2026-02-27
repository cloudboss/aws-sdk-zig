const aws = @import("aws");

/// A dial request for a campaign.
pub const DialRequest = struct {
    attributes: []const aws.map.StringMapEntry,

    client_token: []const u8,

    expiration_time: i64,

    phone_number: []const u8,

    pub const json_field_names = .{
        .attributes = "attributes",
        .client_token = "clientToken",
        .expiration_time = "expirationTime",
        .phone_number = "phoneNumber",
    };
};
