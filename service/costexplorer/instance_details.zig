const EC2InstanceDetails = @import("ec2_instance_details.zig").EC2InstanceDetails;
const ElastiCacheInstanceDetails = @import("elasti_cache_instance_details.zig").ElastiCacheInstanceDetails;
const ESInstanceDetails = @import("es_instance_details.zig").ESInstanceDetails;
const MemoryDBInstanceDetails = @import("memory_db_instance_details.zig").MemoryDBInstanceDetails;
const RDSInstanceDetails = @import("rds_instance_details.zig").RDSInstanceDetails;
const RedshiftInstanceDetails = @import("redshift_instance_details.zig").RedshiftInstanceDetails;

/// Details about the reservations that Amazon Web Services recommends that you
/// purchase.
pub const InstanceDetails = struct {
    /// The Amazon EC2 reservations that Amazon Web Services recommends that you
    /// purchase.
    ec2_instance_details: ?EC2InstanceDetails = null,

    /// The ElastiCache reservations that Amazon Web Services recommends that you
    /// purchase.
    elasti_cache_instance_details: ?ElastiCacheInstanceDetails = null,

    /// The Amazon OpenSearch Service reservations that Amazon Web Services
    /// recommends that you
    /// purchase.
    es_instance_details: ?ESInstanceDetails = null,

    /// The MemoryDB reservations that Amazon Web Services recommends that you
    /// purchase.
    memory_db_instance_details: ?MemoryDBInstanceDetails = null,

    /// The Amazon RDS reservations that Amazon Web Services recommends that you
    /// purchase.
    rds_instance_details: ?RDSInstanceDetails = null,

    /// The Amazon Redshift reservations that Amazon Web Services recommends that
    /// you
    /// purchase.
    redshift_instance_details: ?RedshiftInstanceDetails = null,

    pub const json_field_names = .{
        .ec2_instance_details = "EC2InstanceDetails",
        .elasti_cache_instance_details = "ElastiCacheInstanceDetails",
        .es_instance_details = "ESInstanceDetails",
        .memory_db_instance_details = "MemoryDBInstanceDetails",
        .rds_instance_details = "RDSInstanceDetails",
        .redshift_instance_details = "RedshiftInstanceDetails",
    };
};
