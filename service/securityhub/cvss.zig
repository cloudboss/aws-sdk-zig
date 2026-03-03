const Adjustment = @import("adjustment.zig").Adjustment;

/// CVSS scores from the advisory related to the vulnerability.
pub const Cvss = struct {
    /// Adjustments to the CVSS metrics.
    adjustments: ?[]const Adjustment = null,

    /// The base CVSS score.
    base_score: ?f64 = null,

    /// The base scoring vector for the CVSS score.
    base_vector: ?[]const u8 = null,

    /// The origin of the original CVSS score and vector.
    source: ?[]const u8 = null,

    /// The version of CVSS for the CVSS score.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .adjustments = "Adjustments",
        .base_score = "BaseScore",
        .base_vector = "BaseVector",
        .source = "Source",
        .version = "Version",
    };
};
