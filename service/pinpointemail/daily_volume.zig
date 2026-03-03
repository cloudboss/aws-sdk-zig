const DomainIspPlacement = @import("domain_isp_placement.zig").DomainIspPlacement;
const VolumeStatistics = @import("volume_statistics.zig").VolumeStatistics;

/// An object that contains information about the volume of email sent on each
/// day of the
/// analysis period.
pub const DailyVolume = struct {
    /// An object that contains inbox placement metrics for a specified day in the
    /// analysis
    /// period, broken out by the recipient's email provider.
    domain_isp_placements: ?[]const DomainIspPlacement = null,

    /// The date that the DailyVolume metrics apply to, in Unix time.
    start_date: ?i64 = null,

    /// An object that contains inbox placement metrics for a specific day in the
    /// analysis
    /// period.
    volume_statistics: ?VolumeStatistics = null,

    pub const json_field_names = .{
        .domain_isp_placements = "DomainIspPlacements",
        .start_date = "StartDate",
        .volume_statistics = "VolumeStatistics",
    };
};
