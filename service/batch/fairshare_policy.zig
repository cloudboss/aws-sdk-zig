const ShareAttributes = @import("share_attributes.zig").ShareAttributes;

/// The fair-share scheduling policy details.
pub const FairsharePolicy = struct {
    /// A value used to reserve some of the available maximum vCPU for share
    /// identifiers that
    /// aren't already used.
    ///
    /// The reserved ratio is
    /// `(*computeReservation*/100)^*ActiveFairShares*
    /// `
    /// where `
    /// *ActiveFairShares*
    /// ` is the number of active share
    /// identifiers.
    ///
    /// For example, a `computeReservation` value of 50 indicates that Batch
    /// reserves
    /// 50% of the maximum available vCPU if there's only one share identifier. It
    /// reserves 25% if
    /// there are two share identifiers. It reserves 12.5% if there are three share
    /// identifiers. A `computeReservation` value of 25 indicates that Batch should
    /// reserve
    /// 25% of the maximum available vCPU if there's only one share identifier,
    /// 6.25% if there are
    /// two fair share identifiers, and 1.56% if there are three share identifiers.
    ///
    /// The minimum value is 0 and the maximum value is 99.
    compute_reservation: ?i32 = null,

    /// The amount of time (in seconds) to use to calculate a fair-share percentage
    /// for each
    /// share identifier in use. A value of zero (0) indicates the default minimum
    /// time window (600 seconds).
    /// The maximum supported value is 604800 (1 week).
    ///
    /// The decay allows for more recently run jobs to have more weight than jobs
    /// that ran earlier.
    /// Consider adjusting this number if you have jobs that (on average) run longer
    /// than ten minutes,
    /// or a large difference in job count or job run times between share
    /// identifiers, and the allocation
    /// of resources doesn't meet your needs.
    share_decay_seconds: ?i32 = null,

    /// An array of `SharedIdentifier` objects that contain the weights for the
    /// share identifiers for the fair-share policy. Share identifiers that aren't
    /// included have a
    /// default weight of `1.0`.
    share_distribution: ?[]const ShareAttributes = null,

    pub const json_field_names = .{
        .compute_reservation = "computeReservation",
        .share_decay_seconds = "shareDecaySeconds",
        .share_distribution = "shareDistribution",
    };
};
