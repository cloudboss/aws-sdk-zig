const ContentTypeProfiles = @import("content_type_profiles.zig").ContentTypeProfiles;

/// The configuration for a field-level encryption content type-profile mapping.
pub const ContentTypeProfileConfig = struct {
    /// The configuration for a field-level encryption content type-profile.
    content_type_profiles: ?ContentTypeProfiles,

    /// The setting in a field-level encryption content type-profile mapping that
    /// specifies what to do when an unknown content type is provided for the
    /// profile. If true, content is forwarded without being encrypted when the
    /// content type is unknown. If false (the default), an error is returned when
    /// the content type is unknown.
    forward_when_content_type_is_unknown: bool,
};
