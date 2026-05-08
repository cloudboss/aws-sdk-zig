const TaxEstimation = @import("tax_estimation.zig").TaxEstimation;

/// Configuration controls for tax estimation in the agreement request.
pub const TaxConfiguration = struct {
    /// Toggle to estimate tax as part of the response. Values include `ENABLED` and
    /// `DISABLED`. Default is `DISABLED`.
    tax_estimation: TaxEstimation = .disabled,

    pub const json_field_names = .{
        .tax_estimation = "taxEstimation",
    };
};
