/// A description of the identity.
pub const IdentityDescription = struct {
    /// Date on which the identity was created.
    creation_date: ?i64,

    /// A unique identifier in the format REGION:GUID.
    identity_id: ?[]const u8,

    /// Date on which the identity was last modified.
    last_modified_date: ?i64,

    /// The provider names.
    logins: ?[]const []const u8,

    pub const json_field_names = .{
        .creation_date = "CreationDate",
        .identity_id = "IdentityId",
        .last_modified_date = "LastModifiedDate",
        .logins = "Logins",
    };
};
