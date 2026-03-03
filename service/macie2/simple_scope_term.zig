const JobComparator = @import("job_comparator.zig").JobComparator;
const ScopeFilterKey = @import("scope_filter_key.zig").ScopeFilterKey;

/// Specifies a property-based condition that determines whether an S3 object is
/// included or excluded from a classification job.
pub const SimpleScopeTerm = struct {
    /// The operator to use in the condition. Valid values for each supported
    /// property (key) are:
    ///
    /// * OBJECT_EXTENSION - EQ (equals) or NE (not equals)
    /// * OBJECT_KEY - STARTS_WITH
    /// * OBJECT_LAST_MODIFIED_DATE - EQ (equals), GT (greater than), GTE (greater
    ///   than or equals), LT (less than), LTE (less than or equals), or NE (not
    ///   equals)
    /// * OBJECT_SIZE - EQ (equals), GT (greater than), GTE (greater than or
    ///   equals), LT (less than), LTE (less than or equals), or NE (not equals)
    comparator: ?JobComparator = null,

    /// The object property to use in the condition.
    key: ?ScopeFilterKey = null,

    /// An array that lists the values to use in the condition. If the value for the
    /// key property is OBJECT_EXTENSION or OBJECT_KEY, this array can specify
    /// multiple values and Amazon Macie uses OR logic to join the values.
    /// Otherwise, this array can specify only one value.
    ///
    /// Valid values for each supported property (key) are:
    ///
    /// * OBJECT_EXTENSION - A string that represents the file name extension of an
    ///   object. For example: docx or pdf
    /// * OBJECT_KEY - A string that represents the key prefix (folder name or path)
    ///   of an object. For example: logs or awslogs/eventlogs. This value applies a
    ///   condition to objects whose keys (names) begin with the specified value.
    /// * OBJECT_LAST_MODIFIED_DATE - The date and time (in UTC and extended ISO
    ///   8601 format) when an object was created or last changed, whichever is
    ///   latest. For example: 2023-09-24T14:31:13Z
    /// * OBJECT_SIZE - An integer that represents the storage size (in bytes) of an
    ///   object.
    ///
    /// Macie doesn't support use of wildcard characters in these values. Also,
    /// string values are case sensitive.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .comparator = "comparator",
        .key = "key",
        .values = "values",
    };
};
