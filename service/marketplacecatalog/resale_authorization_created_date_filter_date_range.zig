/// Allows filtering on `CreatedDate` of a ResaleAuthorization with date range
/// as input.
pub const ResaleAuthorizationCreatedDateFilterDateRange = struct {
    /// Allows filtering on `CreatedDate` of a ResaleAuthorization after a date.
    after_value: ?[]const u8 = null,

    /// Allows filtering on `CreatedDate` of a ResaleAuthorization before a date.
    before_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .after_value = "AfterValue",
        .before_value = "BeforeValue",
    };
};
