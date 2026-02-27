const ContentTypeProfile = @import("content_type_profile.zig").ContentTypeProfile;

/// Field-level encryption content type-profile.
pub const ContentTypeProfiles = struct {
    /// Items in a field-level encryption content type-profile mapping.
    items: ?[]const ContentTypeProfile,

    /// The number of field-level encryption content type-profile mappings.
    quantity: i32,
};
