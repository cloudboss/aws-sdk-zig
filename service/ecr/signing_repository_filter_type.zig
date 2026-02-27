/// The type of filter to use when determining which repositories
/// should have their images automatically signed.
pub const SigningRepositoryFilterType = enum {
    wildcard_match,

    pub const json_field_names = .{
        .wildcard_match = "WILDCARD_MATCH",
    };
};
