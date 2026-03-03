const Format = @import("format.zig").Format;

/// A field-level encryption content type profile.
pub const ContentTypeProfile = struct {
    /// The content type for a field-level encryption content type-profile mapping.
    content_type: []const u8,

    /// The format for a field-level encryption content type-profile mapping.
    format: Format,

    /// The profile ID for a field-level encryption content type-profile mapping.
    profile_id: ?[]const u8 = null,
};
