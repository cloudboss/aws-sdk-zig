/// Configuration information of the security key.
pub const SecurityKey = struct {
    /// The existing association identifier that uniquely identifies the resource
    /// type and storage config for the given instance ID.
    association_id: ?[]const u8,

    /// When the security key was created.
    creation_time: ?i64,

    /// The key of the security key.
    key: ?[]const u8,

    pub const json_field_names = .{
        .association_id = "AssociationId",
        .creation_time = "CreationTime",
        .key = "Key",
    };
};
