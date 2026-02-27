/// A filter condition that specifies the object age range of included objects
/// in days. Only integers are supported.
pub const MatchObjectAge = struct {
    /// Specifies the maximum object age in days. Must be a positive whole number,
    /// greater than the minimum object age and less than or equal to 2,147,483,647.
    days_greater_than: i32 = 0,

    /// Specifies the minimum object age in days. The value must be a positive whole
    /// number, greater than 0 and less than or equal to 2,147,483,647.
    days_less_than: i32 = 0,
};
