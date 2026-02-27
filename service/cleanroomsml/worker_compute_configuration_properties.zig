const aws = @import("aws");

/// The configuration properties for the worker compute environment. These
/// properties allow you to customize the compute settings for your Clean Rooms
/// workloads.
pub const WorkerComputeConfigurationProperties = union(enum) {
    /// The Spark configuration properties for SQL workloads. This map contains
    /// key-value pairs that configure Apache Spark settings to optimize performance
    /// for your data processing jobs. You can specify up to 50 Spark properties,
    /// with each key being 1-200 characters and each value being 0-500 characters.
    /// These properties allow you to adjust compute capacity for large datasets and
    /// complex workloads.
    spark: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .spark = "spark",
    };
};
