const StorageProfileOperatingSystemFamily = @import("storage_profile_operating_system_family.zig").StorageProfileOperatingSystemFamily;

/// The details of a storage profile.
pub const StorageProfileSummary = struct {
    /// The display name of the storage profile summary to update.
    ///
    /// This field can store any content. Escape or encode this content before
    /// displaying it on a webpage or any other system that might interpret the
    /// content of this field.
    display_name: []const u8,

    /// The operating system (OS) family.
    os_family: StorageProfileOperatingSystemFamily,

    /// The storage profile ID.
    storage_profile_id: []const u8,

    pub const json_field_names = .{
        .display_name = "displayName",
        .os_family = "osFamily",
        .storage_profile_id = "storageProfileId",
    };
};
