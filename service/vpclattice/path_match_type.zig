/// Describes a path match type. Each rule can include only one of the following
/// types of paths.
pub const PathMatchType = union(enum) {
    /// An exact match of the path.
    exact: ?[]const u8,
    /// A prefix match of the path.
    prefix: ?[]const u8,

    pub const json_field_names = .{
        .exact = "exact",
        .prefix = "prefix",
    };
};
