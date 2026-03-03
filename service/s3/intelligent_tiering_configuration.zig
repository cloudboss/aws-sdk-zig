const IntelligentTieringFilter = @import("intelligent_tiering_filter.zig").IntelligentTieringFilter;
const IntelligentTieringStatus = @import("intelligent_tiering_status.zig").IntelligentTieringStatus;
const Tiering = @import("tiering.zig").Tiering;

/// Specifies the S3 Intelligent-Tiering configuration for an Amazon S3 bucket.
///
/// For information about the S3 Intelligent-Tiering storage class, see [Storage
/// class for
/// automatically optimizing frequently and infrequently accessed
/// objects](https://docs.aws.amazon.com/AmazonS3/latest/dev/storage-class-intro.html#sc-dynamic-data-access).
pub const IntelligentTieringConfiguration = struct {
    /// Specifies a bucket filter. The configuration only includes objects that meet
    /// the filter's
    /// criteria.
    filter: ?IntelligentTieringFilter = null,

    /// The ID used to identify the S3 Intelligent-Tiering configuration.
    id: []const u8,

    /// Specifies the status of the configuration.
    status: IntelligentTieringStatus,

    /// Specifies the S3 Intelligent-Tiering storage class tier of the
    /// configuration.
    tierings: []const Tiering,
};
