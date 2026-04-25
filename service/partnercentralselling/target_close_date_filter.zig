/// Filters opportunities based on their target close date.
pub const TargetCloseDateFilter = struct {
    /// Filters opportunities with a target close date after this date. Use the
    /// `YYYY-MM-DD` format.
    after_target_close_date: ?[]const u8 = null,

    /// Filters opportunities with a target close date before this date. Use the
    /// `YYYY-MM-DD` format.
    before_target_close_date: ?[]const u8 = null,

    pub const json_field_names = .{
        .after_target_close_date = "AfterTargetCloseDate",
        .before_target_close_date = "BeforeTargetCloseDate",
    };
};
