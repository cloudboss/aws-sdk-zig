const Tier = @import("tier.zig").Tier;

/// Container for S3 Glacier job parameters.
pub const GlacierJobParameters = struct {
    /// Retrieval tier at which the restore will be processed.
    tier: Tier,
};
