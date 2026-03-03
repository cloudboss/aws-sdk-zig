const QueryArgProfiles = @import("query_arg_profiles.zig").QueryArgProfiles;

/// Configuration for query argument-profile mapping for field-level encryption.
pub const QueryArgProfileConfig = struct {
    /// Flag to set if you want a request to be forwarded to the origin even if the
    /// profile specified by the field-level encryption query argument, fle-profile,
    /// is unknown.
    forward_when_query_arg_profile_is_unknown: bool,

    /// Profiles specified for query argument-profile mapping for field-level
    /// encryption.
    query_arg_profiles: ?QueryArgProfiles = null,
};
