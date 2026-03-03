const DetailStatus = @import("detail_status.zig").DetailStatus;

/// An object that describes the details for a specified dimension.
pub const DimensionKeyDetail = struct {
    /// The full name of the dimension. The full name includes the group name and
    /// key name. The following values are valid:
    ///
    /// * `db.query.statement` (Amazon DocumentDB)
    ///
    /// * `db.sql.statement` (Amazon RDS and Aurora)
    dimension: ?[]const u8 = null,

    /// The status of the dimension detail data. Possible values include the
    /// following:
    ///
    /// * `AVAILABLE` - The dimension detail data is ready to be retrieved.
    ///
    /// * `PROCESSING` - The dimension detail data isn't ready to be retrieved
    ///   because more processing time is required. If the
    /// requested detail data has the status `PROCESSING`, Performance Insights
    /// returns the truncated query.
    ///
    /// * `UNAVAILABLE` - The dimension detail data could not be collected
    ///   successfully.
    status: ?DetailStatus = null,

    /// The value of the dimension detail data. Depending on the return status, this
    /// value is either the
    /// full or truncated SQL query for the following dimensions:
    ///
    /// * `db.query.statement` (Amazon DocumentDB)
    ///
    /// * `db.sql.statement` (Amazon RDS and Aurora)
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .dimension = "Dimension",
        .status = "Status",
        .value = "Value",
    };
};
