/// A filter that can be used to list command executions for a device that
/// started or
/// completed before or after a particular date and time.
pub const TimeFilter = struct {
    /// Filter to display command executions that started or completed only after a
    /// particular
    /// date and time.
    after: ?[]const u8,

    /// Filter to display command executions that started or completed only before a
    /// particular date and time.
    before: ?[]const u8,

    pub const json_field_names = .{
        .after = "after",
        .before = "before",
    };
};
