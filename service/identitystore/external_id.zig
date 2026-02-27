/// The identifier issued to this resource by an external identity provider.
pub const ExternalId = struct {
    /// The identifier issued to this resource by an external identity provider.
    id: []const u8,

    /// The issuer for an external identifier.
    issuer: []const u8,

    pub const json_field_names = .{
        .id = "Id",
        .issuer = "Issuer",
    };
};
