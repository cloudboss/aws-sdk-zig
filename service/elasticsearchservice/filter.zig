/// A filter used to limit results when describing inbound or outbound
/// cross-cluster search connections.
/// Multiple values can be specified per filter.
/// A cross-cluster search connection must match at least one of the specified
/// values for it to be
/// returned from an operation.
pub const Filter = struct {
    /// Specifies the name of the filter.
    name: ?[]const u8 = null,

    /// Contains one or more values for the filter.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
