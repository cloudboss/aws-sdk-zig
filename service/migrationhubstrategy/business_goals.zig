/// Business goals that you specify.
pub const BusinessGoals = struct {
    /// Business goal to reduce license costs.
    license_cost_reduction: ?i32,

    /// Business goal to modernize infrastructure by moving to cloud native
    /// technologies.
    modernize_infrastructure_with_cloud_native_technologies: ?i32,

    /// Business goal to reduce the operational overhead on the team by moving into
    /// managed
    /// services.
    reduce_operational_overhead_with_managed_services: ?i32,

    /// Business goal to achieve migration at a fast pace.
    speed_of_migration: ?i32,

    pub const json_field_names = .{
        .license_cost_reduction = "licenseCostReduction",
        .modernize_infrastructure_with_cloud_native_technologies = "modernizeInfrastructureWithCloudNativeTechnologies",
        .reduce_operational_overhead_with_managed_services = "reduceOperationalOverheadWithManagedServices",
        .speed_of_migration = "speedOfMigration",
    };
};
