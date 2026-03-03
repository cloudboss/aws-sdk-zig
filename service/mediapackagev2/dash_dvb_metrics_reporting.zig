/// For use with DVB-DASH profiles only. The settings for error reporting from
/// the playback device that you want Elemental MediaPackage to pass through to
/// the manifest.
pub const DashDvbMetricsReporting = struct {
    /// The number of playback devices per 1000 that will send error reports to the
    /// reporting URL. This represents the probability that a playback device will
    /// be a reporting player for this session.
    probability: ?i32 = null,

    /// The URL where playback devices send error reports.
    reporting_url: []const u8,

    pub const json_field_names = .{
        .probability = "Probability",
        .reporting_url = "ReportingUrl",
    };
};
