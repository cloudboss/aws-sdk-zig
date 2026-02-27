const LicenseEdition = @import("license_edition.zig").LicenseEdition;
const LicenseModel = @import("license_model.zig").LicenseModel;
const SavingsOpportunity = @import("savings_opportunity.zig").SavingsOpportunity;

/// Describes the recommendation options for licenses.
pub const LicenseRecommendationOption = struct {
    /// The recommended edition of the license for the application that runs on the
    /// instance.
    license_edition: ?LicenseEdition,

    /// The recommended license type associated with the instance.
    license_model: ?LicenseModel,

    /// The operating system of a license recommendation option.
    operating_system: ?[]const u8,

    /// The rank of the license recommendation option.
    ///
    /// The top recommendation option is ranked as `1`.
    rank: i32 = 0,

    savings_opportunity: ?SavingsOpportunity,

    pub const json_field_names = .{
        .license_edition = "licenseEdition",
        .license_model = "licenseModel",
        .operating_system = "operatingSystem",
        .rank = "rank",
        .savings_opportunity = "savingsOpportunity",
    };
};
