/// Statistics such as input rows and bytes read by the query, rows and bytes
/// output by
/// the query, and the number of rows written by the query.
pub const QueryRuntimeStatisticsRows = struct {
    /// The number of bytes read to execute the query.
    input_bytes: ?i64 = null,

    /// The number of rows read to execute the query.
    input_rows: ?i64 = null,

    /// The number of bytes returned by the query.
    output_bytes: ?i64 = null,

    /// The number of rows returned by the query.
    output_rows: ?i64 = null,

    pub const json_field_names = .{
        .input_bytes = "InputBytes",
        .input_rows = "InputRows",
        .output_bytes = "OutputBytes",
        .output_rows = "OutputRows",
    };
};
