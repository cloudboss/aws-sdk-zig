/// A filter used to limit results when describing inbound or outbound
/// cross-cluster
/// connections. You can specify multiple values per filter. A cross-cluster
/// connection must
/// match at least one of the specified values for it to be returned from an
/// operation.
pub const Filter = struct {
    /// The name of the filter.
    name: ?[]const u8,

    /// One or more values for the filter.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
