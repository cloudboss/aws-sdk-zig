const ExternalId = @import("external_id.zig").ExternalId;

/// A group object that contains the metadata and attributes for a specified
/// group.
pub const Group = struct {
    /// The date and time the group was created.
    created_at: ?i64 = null,

    /// The identifier of the user or system that created the group.
    created_by: ?[]const u8 = null,

    /// A string containing a description of the specified group.
    description: ?[]const u8 = null,

    /// The display name value for the group. The length limit is 1,024 characters.
    /// This value can consist of letters, accented characters, symbols, numbers,
    /// punctuation, tab, new line, carriage return, space, and nonbreaking space in
    /// this attribute. This value is specified at the time the group is created and
    /// stored as an attribute of the group object in the identity store.
    ///
    /// Prefix search supports a maximum of 1,000 characters for the string.
    display_name: ?[]const u8 = null,

    /// A list of `ExternalId` objects that contains the identifiers issued to this
    /// resource by an external identity provider.
    external_ids: ?[]const ExternalId = null,

    /// The identifier for a group in the identity store.
    group_id: []const u8,

    /// The globally unique identifier for the identity store.
    identity_store_id: []const u8,

    /// The date and time the group was last updated.
    updated_at: ?i64 = null,

    /// The identifier of the user or system that last updated the group.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .created_by = "CreatedBy",
        .description = "Description",
        .display_name = "DisplayName",
        .external_ids = "ExternalIds",
        .group_id = "GroupId",
        .identity_store_id = "IdentityStoreId",
        .updated_at = "UpdatedAt",
        .updated_by = "UpdatedBy",
    };
};
