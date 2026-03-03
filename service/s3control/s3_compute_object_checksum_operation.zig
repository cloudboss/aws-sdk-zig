const ComputeObjectChecksumAlgorithm = @import("compute_object_checksum_algorithm.zig").ComputeObjectChecksumAlgorithm;
const ComputeObjectChecksumType = @import("compute_object_checksum_type.zig").ComputeObjectChecksumType;

/// Directs the specified job to invoke the ComputeObjectChecksum operation on
/// every object listed in the job's manifest.
pub const S3ComputeObjectChecksumOperation = struct {
    /// Indicates the algorithm that you want Amazon S3 to use to create the
    /// checksum. For more information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in the Amazon S3 User Guide.
    checksum_algorithm: ?ComputeObjectChecksumAlgorithm = null,

    /// Indicates the checksum type that you want Amazon S3 to use to calculate the
    /// object's checksum value. For more information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in the Amazon S3 User Guide.
    checksum_type: ?ComputeObjectChecksumType = null,
};
