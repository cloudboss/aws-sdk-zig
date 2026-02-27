/// Allows filtering on the `LastModifiedDate` of a ResaleAuthorization with
/// date range as input.
pub const ResaleAuthorizationLastModifiedDateFilterDateRange = struct {
    /// Allows filtering on the `LastModifiedDate` of a ResaleAuthorization after a
    /// date.
    after_value: ?[]const u8,

    /// Allows filtering on the `LastModifiedDate` of a ResaleAuthorization before a
    /// date.
    before_value: ?[]const u8,

    pub const json_field_names = .{
        .after_value = "AfterValue",
        .before_value = "BeforeValue",
    };
};
