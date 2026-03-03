/// A summary report for the attribute for a Region.
pub const RegionalSummary = struct {
    /// The number of accounts in the Region with the same configuration value for
    /// the
    /// attribute that is most frequently observed.
    number_of_matched_accounts: ?i32 = null,

    /// The number of accounts in the Region with a configuration value different
    /// from the
    /// most frequently observed value for the attribute.
    number_of_unmatched_accounts: ?i32 = null,

    /// The Amazon Web Services Region.
    region_name: ?[]const u8 = null,
};
