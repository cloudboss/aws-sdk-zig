/// An entity contains data that describes your product, its supported features,
/// and how
/// it can be used or launched by your customer.
pub const Entity = struct {
    /// The identifier for the entity.
    identifier: ?[]const u8,

    /// The type of entity.
    @"type": []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
        .@"type" = "Type",
    };
};
