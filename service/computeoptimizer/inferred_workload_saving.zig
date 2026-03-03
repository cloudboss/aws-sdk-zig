const EstimatedMonthlySavings = @import("estimated_monthly_savings.zig").EstimatedMonthlySavings;
const InferredWorkloadType = @import("inferred_workload_type.zig").InferredWorkloadType;

/// The estimated monthly savings after you adjust the configurations of your
/// instances running on the
/// inferred workload types to the recommended configurations. If the
/// `inferredWorkloadTypes`
/// list contains multiple entries, then the savings are the sum of the monthly
/// savings from instances
/// that run the exact combination of the inferred workload types.
pub const InferredWorkloadSaving = struct {
    /// An object that describes the estimated monthly savings amount possible by
    /// adopting Compute Optimizer recommendations for a given
    /// resource. This is based on the On-Demand instance pricing.
    estimated_monthly_savings: ?EstimatedMonthlySavings = null,

    /// The applications that might be running on the instance as inferred by
    /// Compute Optimizer.
    ///
    /// Compute Optimizer can infer if one of the following applications might be
    /// running on
    /// the instance:
    ///
    /// * `AmazonEmr` - Infers that Amazon EMR might be running on
    /// the instance.
    ///
    /// * `ApacheCassandra` - Infers that Apache Cassandra might be running
    /// on the instance.
    ///
    /// * `ApacheHadoop` - Infers that Apache Hadoop might be running on the
    /// instance.
    ///
    /// * `Memcached` - Infers that Memcached might be running on the
    /// instance.
    ///
    /// * `NGINX` - Infers that NGINX might be running on the
    /// instance.
    ///
    /// * `PostgreSql` - Infers that PostgreSQL might be running on the
    /// instance.
    ///
    /// * `Redis` - Infers that Redis might be running on the
    /// instance.
    ///
    /// * `Kafka` - Infers that Kafka might be running on the
    /// instance.
    ///
    /// * `SQLServer` - Infers that SQLServer might be running on the
    /// instance.
    inferred_workload_types: ?[]const InferredWorkloadType = null,

    pub const json_field_names = .{
        .estimated_monthly_savings = "estimatedMonthlySavings",
        .inferred_workload_types = "inferredWorkloadTypes",
    };
};
