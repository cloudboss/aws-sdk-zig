const SigningRepositoryFilterType = @import("signing_repository_filter_type.zig").SigningRepositoryFilterType;

/// A repository filter used to determine which repositories have their
/// images automatically signed on push. Each filter consists of a filter type
/// and filter value.
pub const SigningRepositoryFilter = struct {
    /// The filter value used to match repository names. When using
    /// `WILDCARD_MATCH`, the `*` character matches any sequence of characters.
    ///
    /// Examples:
    ///
    /// * `myapp/*` - Matches all repositories starting with
    /// `myapp/`
    ///
    /// * `*/production` - Matches all repositories ending with
    /// `/production`
    ///
    /// * `*prod*` - Matches all repositories containing
    /// `prod`
    filter: []const u8,

    /// The type of filter to apply. Currently, only `WILDCARD_MATCH` is supported,
    /// which uses wildcard patterns to match repository names.
    filter_type: SigningRepositoryFilterType,

    pub const json_field_names = .{
        .filter = "filter",
        .filter_type = "filterType",
    };
};
