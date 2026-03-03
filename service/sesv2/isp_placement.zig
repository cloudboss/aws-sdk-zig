const PlacementStatistics = @import("placement_statistics.zig").PlacementStatistics;

/// An object that describes how email sent during the predictive inbox
/// placement test was handled by a certain
/// email provider.
pub const IspPlacement = struct {
    /// The name of the email provider that the inbox placement data applies to.
    isp_name: ?[]const u8 = null,

    /// An object that contains inbox placement metrics for a specific email
    /// provider.
    placement_statistics: ?PlacementStatistics = null,

    pub const json_field_names = .{
        .isp_name = "IspName",
        .placement_statistics = "PlacementStatistics",
    };
};
