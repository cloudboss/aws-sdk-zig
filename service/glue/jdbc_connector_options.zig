const aws = @import("aws");

const GlueRecordType = @import("glue_record_type.zig").GlueRecordType;

/// Additional connection options for the connector.
pub const JDBCConnectorOptions = struct {
    /// Custom data type mapping that builds a mapping from a JDBC data type to an
    /// Glue data type. For example, the option
    /// `"dataTypeMapping":{"FLOAT":"STRING"}` maps data fields of JDBC type `FLOAT`
    /// into the Java `String` type by calling the `ResultSet.getString()` method of
    /// the driver, and uses it to build the Glue record. The `ResultSet` object is
    /// implemented by each driver, so the behavior is specific to the driver you
    /// use. Refer to the documentation for your JDBC driver to understand how the
    /// driver performs the conversions.
    data_type_mapping: ?[]const aws.map.MapEntry(GlueRecordType),

    /// Extra condition clause to filter data from source. For example:
    ///
    /// `BillingCity='Mountain View'`
    ///
    /// When using a query instead of a table name, you should validate that the
    /// query works with the specified `filterPredicate`.
    filter_predicate: ?[]const u8,

    /// The name of the job bookmark keys on which to sort.
    job_bookmark_keys: ?[]const []const u8,

    /// Specifies an ascending or descending sort order.
    job_bookmark_keys_sort_order: ?[]const u8,

    /// The minimum value of `partitionColumn` that is used to decide partition
    /// stride.
    lower_bound: ?i64,

    /// The number of partitions. This value, along with `lowerBound` (inclusive)
    /// and `upperBound` (exclusive), form partition strides for generated `WHERE`
    /// clause expressions that are used to split the `partitionColumn`.
    num_partitions: ?i64,

    /// The name of an integer column that is used for partitioning. This option
    /// works only when it's included with `lowerBound`, `upperBound`, and
    /// `numPartitions`. This option works the same way as in the Spark SQL JDBC
    /// reader.
    partition_column: ?[]const u8,

    /// The maximum value of `partitionColumn` that is used to decide partition
    /// stride.
    upper_bound: ?i64,

    pub const json_field_names = .{
        .data_type_mapping = "DataTypeMapping",
        .filter_predicate = "FilterPredicate",
        .job_bookmark_keys = "JobBookmarkKeys",
        .job_bookmark_keys_sort_order = "JobBookmarkKeysSortOrder",
        .lower_bound = "LowerBound",
        .num_partitions = "NumPartitions",
        .partition_column = "PartitionColumn",
        .upper_bound = "UpperBound",
    };
};
