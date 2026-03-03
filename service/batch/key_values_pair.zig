/// A filter name and value pair that's used to return a more specific list of
/// results from a
/// `ListJobs` or `ListJobsByConsumableResource` API operation.
pub const KeyValuesPair = struct {
    /// The name of the filter. Filter names are case sensitive.
    name: ?[]const u8 = null,

    /// The filter values.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
