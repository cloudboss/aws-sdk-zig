/// A key-value pair that identifies how log groups are grouped in aggregate
/// summaries.
pub const GroupingIdentifier = struct {
    /// The key that identifies the grouping characteristic. The format of the key
    /// uses dot
    /// notation. Examples are, `dataSource.Name`, `dataSource.Type`, and
    /// `dataSource.Format`.
    key: ?[]const u8,

    /// The value associated with the grouping characteristic. Examples are
    /// `amazon_vpc`, `flow`, and `OCSF`.
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
