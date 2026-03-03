/// Defines a filter to retrieve opportunities based on the last modified date.
/// This filter is useful for tracking changes or updates to opportunities over
/// time.
pub const LastModifiedDate = struct {
    /// Specifies the date after which the opportunities were modified. Use this
    /// filter to retrieve only those opportunities that were modified after a given
    /// timestamp.
    after_last_modified_date: ?i64 = null,

    /// Specifies the date before which the opportunities were modified. Use this
    /// filter to retrieve only those opportunities that were modified before a
    /// given timestamp.
    before_last_modified_date: ?i64 = null,

    pub const json_field_names = .{
        .after_last_modified_date = "AfterLastModifiedDate",
        .before_last_modified_date = "BeforeLastModifiedDate",
    };
};
