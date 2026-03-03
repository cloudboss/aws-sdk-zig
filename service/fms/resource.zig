/// Details of a resource that is associated to an Firewall Manager resource
/// set.
pub const Resource = struct {
    /// The Amazon Web Services account ID that the associated resource belongs to.
    account_id: ?[]const u8 = null,

    /// The resource's universal resource indicator (URI).
    uri: []const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .uri = "URI",
    };
};
