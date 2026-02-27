const Coverage = @import("coverage.zig").Coverage;

/// Configuration for resold business support plans.
pub const ResoldBusiness = struct {
    /// The coverage level for resold business support.
    coverage: Coverage,

    pub const json_field_names = .{
        .coverage = "coverage",
    };
};
