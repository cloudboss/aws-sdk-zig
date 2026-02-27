const Coverage = @import("coverage.zig").Coverage;

/// Configuration for resold enterprise support plans.
pub const ResoldEnterprise = struct {
    /// The AWS account ID to charge for the support plan.
    charge_account_id: ?[]const u8,

    /// The coverage level for resold enterprise support.
    coverage: Coverage,

    /// The location of the Technical Account Manager (TAM).
    tam_location: []const u8,

    pub const json_field_names = .{
        .charge_account_id = "chargeAccountId",
        .coverage = "coverage",
        .tam_location = "tamLocation",
    };
};
