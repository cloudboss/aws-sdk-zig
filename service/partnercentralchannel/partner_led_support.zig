const Coverage = @import("coverage.zig").Coverage;
const Provider = @import("provider.zig").Provider;

/// Configuration for partner-led support plans.
pub const PartnerLedSupport = struct {
    /// The coverage level for partner-led support.
    coverage: Coverage,

    /// The provider of the partner-led support.
    provider: ?Provider = null,

    /// The location of the Technical Account Manager (TAM).
    tam_location: []const u8,

    pub const json_field_names = .{
        .coverage = "coverage",
        .provider = "provider",
        .tam_location = "tamLocation",
    };
};
