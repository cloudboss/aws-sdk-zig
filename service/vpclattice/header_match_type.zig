/// Describes a header match type.
pub const HeaderMatchType = union(enum) {
    /// A contains type match.
    contains: ?[]const u8,
    /// An exact type match.
    exact: ?[]const u8,
    /// A prefix type match. Matches the value with the prefix.
    prefix: ?[]const u8,

    pub const json_field_names = .{
        .contains = "contains",
        .exact = "exact",
        .prefix = "prefix",
    };
};
