/// Specifies a rule that controls when cached data expires from the file system
/// based on last access time.
pub const ExpirationDataRule = struct {
    /// The number of days after last access before cached data expires from the
    /// file system.
    days_after_last_access: i32,

    pub const json_field_names = .{
        .days_after_last_access = "daysAfterLastAccess",
    };
};
