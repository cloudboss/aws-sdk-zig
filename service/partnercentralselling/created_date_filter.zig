/// Filter for opportunities based on creation date range.
pub const CreatedDateFilter = struct {
    /// Filter opportunities created after this date.
    after_created_date: ?i64 = null,

    /// Filter opportunities created before this date.
    before_created_date: ?i64 = null,

    pub const json_field_names = .{
        .after_created_date = "AfterCreatedDate",
        .before_created_date = "BeforeCreatedDate",
    };
};
