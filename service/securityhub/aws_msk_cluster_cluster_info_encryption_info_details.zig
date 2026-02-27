const AwsMskClusterClusterInfoEncryptionInfoEncryptionAtRestDetails = @import("aws_msk_cluster_cluster_info_encryption_info_encryption_at_rest_details.zig").AwsMskClusterClusterInfoEncryptionInfoEncryptionAtRestDetails;
const AwsMskClusterClusterInfoEncryptionInfoEncryptionInTransitDetails = @import("aws_msk_cluster_cluster_info_encryption_info_encryption_in_transit_details.zig").AwsMskClusterClusterInfoEncryptionInfoEncryptionInTransitDetails;

/// Includes encryption-related information, such as the KMS key used for
/// encrypting data at rest and
/// whether you want MSK to encrypt your data in transit.
pub const AwsMskClusterClusterInfoEncryptionInfoDetails = struct {
    /// The data-volume encryption details. You can't update encryption at rest
    /// settings for existing clusters.
    encryption_at_rest: ?AwsMskClusterClusterInfoEncryptionInfoEncryptionAtRestDetails,

    /// The settings for encrypting data in transit.
    encryption_in_transit: ?AwsMskClusterClusterInfoEncryptionInfoEncryptionInTransitDetails,

    pub const json_field_names = .{
        .encryption_at_rest = "EncryptionAtRest",
        .encryption_in_transit = "EncryptionInTransit",
    };
};
