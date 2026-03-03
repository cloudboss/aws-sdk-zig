const RecommendationData = @import("recommendation_data.zig").RecommendationData;
const RecommendationSettings = @import("recommendation_settings.zig").RecommendationSettings;

/// Provides information that describes a recommendation of a target engine.
///
/// A *recommendation* is a set of possible Amazon Web Services target engines
/// that
/// you can choose to migrate your source on-premises database. In this set,
/// Fleet Advisor
/// suggests a single target engine as the right sized migration destination. To
/// determine
/// this rightsized migration destination, Fleet Advisor uses the inventory
/// metadata and
/// metrics from data collector. You can use recommendations before the start of
/// migration
/// to save costs and reduce risks.
///
/// With recommendations, you can explore different target options and compare
/// metrics, so
/// you can make an informed decision when you choose the migration target.
pub const Recommendation = struct {
    /// The date when Fleet Advisor created the target engine recommendation.
    created_date: ?[]const u8 = null,

    /// The recommendation of a target engine for the specified source database.
    data: ?RecommendationData = null,

    /// The identifier of the source database for which Fleet Advisor provided this
    /// recommendation.
    database_id: ?[]const u8 = null,

    /// The name of the target engine. Valid values include `"rds-aurora-mysql"`,
    /// `"rds-aurora-postgresql"`, `"rds-mysql"`,
    /// `"rds-oracle"`, `"rds-sql-server"`, and
    /// `"rds-postgresql"`.
    engine_name: ?[]const u8 = null,

    /// Indicates that this target is the rightsized migration destination.
    preferred: ?bool = null,

    /// The settings in JSON format for the preferred target engine parameters.
    /// These
    /// parameters include capacity, resource utilization, and the usage type
    /// (production,
    /// development, or testing).
    settings: ?RecommendationSettings = null,

    /// The status of the target engine recommendation. Valid values include
    /// `"alternate"`, `"in-progress"`, `"not-viable"`, and
    /// `"recommended"`.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_date = "CreatedDate",
        .data = "Data",
        .database_id = "DatabaseId",
        .engine_name = "EngineName",
        .preferred = "Preferred",
        .settings = "Settings",
        .status = "Status",
    };
};
