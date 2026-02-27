/// Indicates the sorting order of the fields in the metrics.
pub const Sort = struct {
    /// Indicates the name or identifier of the field or attribute that should be
    /// used as the basis for sorting the metrics.
    ascending: ?bool,

    /// Indicates the order in which you want to sort the metrics. By default, the
    /// list is sorted in ascending order. To sort the list in descending order, set
    /// this field to False.
    field: []const u8,

    pub const json_field_names = .{
        .ascending = "ascending",
        .field = "field",
    };
};
