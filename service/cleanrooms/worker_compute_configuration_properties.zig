const aws = @import("aws");

/// The configuration properties that define the compute environment settings
/// for workers in Clean Rooms. These properties enable customization of the
/// underlying compute environment to optimize performance for your specific
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
