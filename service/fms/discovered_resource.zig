/// A resource in the organization that's available to be associated with a
/// Firewall Manager resource set.
pub const DiscoveredResource = struct {
    /// The Amazon Web Services account ID associated with the discovered resource.
    account_id: ?[]const u8,

    /// The name of the discovered resource.
    name: ?[]const u8,

    /// The type of the discovered resource.
    type: ?[]const u8,

    /// The universal resource identifier (URI) of the discovered resource.
    uri: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .name = "Name",
        .type = "Type",
        .uri = "URI",
    };
};
