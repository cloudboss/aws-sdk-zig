const OwnerOverride = @import("owner_override.zig").OwnerOverride;

/// A container for information about access control for replicas.
///
/// This is not supported by Amazon S3 on Outposts buckets.
pub const AccessControlTranslation = struct {
    /// Specifies the replica ownership.
    owner: OwnerOverride,
};
