/// Specify the strength of the Bandwidth reduction filter. For most workflows,
/// we recommend that you choose Auto to reduce the bandwidth of your output
/// with little to no perceptual decrease in video quality. For high quality and
/// high bitrate outputs, choose Low. For the most bandwidth reduction, choose
/// High. We recommend that you choose High for low bitrate outputs. Note that
/// High may incur a slight increase in the softness of your output.
pub const BandwidthReductionFilterStrength = enum {
    low,
    medium,
    high,
    auto,
    off,

    pub const json_field_names = .{
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
        .auto = "AUTO",
        .off = "OFF",
    };
};
