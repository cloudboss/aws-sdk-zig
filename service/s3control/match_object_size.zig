/// A filter condition that specifies the object size range of included objects
/// in bytes. Only integers are supported.
pub const MatchObjectSize = struct {
    /// Specifies the minimum object size in Bytes. The value must be a positive
    /// number, greater than
    /// 0 and less than 50 TB.
    bytes_greater_than: i64 = 0,

    /// Specifies the maximum object size in Bytes. The value must be a positive
    /// number, greater than
    /// the minimum object size and less than 50 TB.
    bytes_less_than: i64 = 0,
};
