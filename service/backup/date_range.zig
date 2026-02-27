/// This is a resource filter containing FromDate: DateTime
/// and ToDate: DateTime. Both values are required. Future DateTime
/// values are not permitted.
///
/// The date and time are in Unix format and Coordinated
/// Universal Time (UTC), and it is accurate to milliseconds
/// ((milliseconds are optional).
/// For example, the value 1516925490.087 represents Friday, January
/// 26, 2018 12:11:30.087 AM.
pub const DateRange = struct {
    /// This value is the beginning date, inclusive.
    ///
    /// The date and time are in Unix format and Coordinated
    /// Universal Time (UTC), and it is accurate to milliseconds
    /// (milliseconds are optional).
    from_date: i64,

    /// This value is the end date, inclusive.
    ///
    /// The date and time are in Unix format and Coordinated
    /// Universal Time (UTC), and it is accurate to milliseconds
    /// (milliseconds are optional).
    to_date: i64,

    pub const json_field_names = .{
        .from_date = "FromDate",
        .to_date = "ToDate",
    };
};
