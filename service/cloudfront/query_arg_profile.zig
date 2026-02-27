/// Query argument-profile mapping for field-level encryption.
pub const QueryArgProfile = struct {
    /// ID of profile to use for field-level encryption query argument-profile
    /// mapping
    profile_id: []const u8,

    /// Query argument for field-level encryption query argument-profile mapping.
    query_arg: []const u8,
};
