/// The latest known metered size (in bytes) of data stored in the file system,
/// in its
/// `Value` field, and the time at which that size was determined in its
/// `Timestamp` field. The value doesn't represent the size of a consistent
/// snapshot of the file system, but it is eventually consistent when there are
/// no writes to the
/// file system. That is, the value represents the actual size only if the file
/// system is not
/// modified for a period longer than a couple of hours. Otherwise, the value is
/// not necessarily
/// the exact size the file system was at any instant in time.
pub const FileSystemSize = struct {
    /// The time at which the size of data, returned in the `Value` field, was
    /// determined. The value is the integer number of seconds since
    /// 1970-01-01T00:00:00Z.
    timestamp: ?i64,

    /// The latest known metered size (in bytes) of data stored in the file system.
    value: i64 = 0,

    /// The latest known metered size (in bytes) of data stored in the Archive
    /// storage class.
    value_in_archive: ?i64,

    /// The latest known metered size (in bytes) of data stored in the Infrequent
    /// Access storage
    /// class.
    value_in_ia: ?i64,

    /// The latest known metered size (in bytes) of data stored in the Standard
    /// storage class.
    value_in_standard: ?i64,

    pub const json_field_names = .{
        .timestamp = "Timestamp",
        .value = "Value",
        .value_in_archive = "ValueInArchive",
        .value_in_ia = "ValueInIA",
        .value_in_standard = "ValueInStandard",
    };
};
