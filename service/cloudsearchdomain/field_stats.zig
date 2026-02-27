/// The statistics for a field calculated in the request.
pub const FieldStats = struct {
    /// The number of documents that contain a value in the specified field in the
    /// result set.
    count: i64 = 0,

    /// The maximum value found in the specified field in the result set.
    ///
    /// If the field is numeric (`int`, `int-array`, `double`, or `double-array`),
    /// `max` is the string representation of a double-precision 64-bit floating
    /// point value. If the field is `date` or `date-array`, `max` is the string
    /// representation of a date with the format specified in [IETF
    /// RFC3339](http://tools.ietf.org/html/rfc3339): yyyy-mm-ddTHH:mm:ss.SSSZ.
    max: ?[]const u8,

    /// The average of the values found in the specified field in the result set.
    ///
    /// If the field is numeric (`int`, `int-array`, `double`, or `double-array`),
    /// `mean` is the string representation of a double-precision 64-bit floating
    /// point value. If the field is `date` or `date-array`, `mean` is the string
    /// representation of a date with the format specified in [IETF
    /// RFC3339](http://tools.ietf.org/html/rfc3339): yyyy-mm-ddTHH:mm:ss.SSSZ.
    mean: ?[]const u8,

    /// The minimum value found in the specified field in the result set.
    ///
    /// If the field is numeric (`int`, `int-array`, `double`, or `double-array`),
    /// `min` is the string representation of a double-precision 64-bit floating
    /// point value. If the field is `date` or `date-array`, `min` is the string
    /// representation of a date with the format specified in [IETF
    /// RFC3339](http://tools.ietf.org/html/rfc3339): yyyy-mm-ddTHH:mm:ss.SSSZ.
    min: ?[]const u8,

    /// The number of documents that do not contain a value in the specified field
    /// in the result set.
    missing: i64 = 0,

    /// The standard deviation of the values in the specified field in the result
    /// set.
    stddev: f64 = 0,

    /// The sum of the field values across the documents in the result set. `null`
    /// for date fields.
    sum: f64 = 0,

    /// The sum of all field values in the result set squared.
    sum_of_squares: f64 = 0,

    pub const json_field_names = .{
        .count = "count",
        .max = "max",
        .mean = "mean",
        .min = "min",
        .missing = "missing",
        .stddev = "stddev",
        .sum = "sum",
        .sum_of_squares = "sumOfSquares",
    };
};
