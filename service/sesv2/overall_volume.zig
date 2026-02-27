const DomainIspPlacement = @import("domain_isp_placement.zig").DomainIspPlacement;
const VolumeStatistics = @import("volume_statistics.zig").VolumeStatistics;

/// An object that contains information about email that was sent from the
/// selected
/// domain.
pub const OverallVolume = struct {
    /// An object that contains inbox and junk mail placement metrics for individual
    /// email
    /// providers.
    domain_isp_placements: ?[]const DomainIspPlacement,

    /// The percentage of emails that were sent from the domain that were read by
    /// their
    /// recipients.
    read_rate_percent: ?f64,

    /// An object that contains information about the numbers of messages that
    /// arrived in
    /// recipients' inboxes and junk mail folders.
    volume_statistics: ?VolumeStatistics,

    pub const json_field_names = .{
        .domain_isp_placements = "DomainIspPlacements",
        .read_rate_percent = "ReadRatePercent",
        .volume_statistics = "VolumeStatistics",
    };
};
