const CisSecurityLevelComparison = @import("cis_security_level_comparison.zig").CisSecurityLevelComparison;
const CisSecurityLevel = @import("cis_security_level.zig").CisSecurityLevel;

/// The CIS security level filter. Security level refers to the Benchmark levels
/// that CIS
/// assigns to a profile.
pub const CisSecurityLevelFilter = struct {
    /// The CIS security filter comparison value.
    comparison: CisSecurityLevelComparison,

    /// The CIS security filter value.
    value: CisSecurityLevel,

    pub const json_field_names = .{
        .comparison = "comparison",
        .value = "value",
    };
};
