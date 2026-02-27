const aws = @import("aws");

const DisruptionCompliance = @import("disruption_compliance.zig").DisruptionCompliance;
const Cost = @import("cost.zig").Cost;
const HaArchitecture = @import("ha_architecture.zig").HaArchitecture;
const ConfigRecommendationOptimizationType = @import("config_recommendation_optimization_type.zig").ConfigRecommendationOptimizationType;
const RecommendationDisruptionCompliance = @import("recommendation_disruption_compliance.zig").RecommendationDisruptionCompliance;

/// Defines a recommendation configuration.
pub const ConfigRecommendation = struct {
    /// Name of the Application Component.
    app_component_name: ?[]const u8,

    /// The current compliance against the resiliency policy before applying the
    /// configuration
    /// change.
    compliance: ?[]const aws.map.MapEntry(DisruptionCompliance),

    /// The cost for the application.
    cost: ?Cost,

    /// The optional description for an app.
    description: ?[]const u8,

    /// The architecture type.
    ha_architecture: ?HaArchitecture,

    /// The name of the recommendation configuration.
    name: []const u8,

    /// The type of optimization.
    optimization_type: ConfigRecommendationOptimizationType,

    /// The expected compliance against the resiliency policy after applying the
    /// configuration
    /// change.
    recommendation_compliance: ?[]const aws.map.MapEntry(RecommendationDisruptionCompliance),

    /// Reference identifier for the recommendation configuration.
    reference_id: []const u8,

    /// List of the suggested configuration changes.
    suggested_changes: ?[]const []const u8,

    pub const json_field_names = .{
        .app_component_name = "appComponentName",
        .compliance = "compliance",
        .cost = "cost",
        .description = "description",
        .ha_architecture = "haArchitecture",
        .name = "name",
        .optimization_type = "optimizationType",
        .recommendation_compliance = "recommendationCompliance",
        .reference_id = "referenceId",
        .suggested_changes = "suggestedChanges",
    };
};
