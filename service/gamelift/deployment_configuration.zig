const DeploymentImpairmentStrategy = @import("deployment_impairment_strategy.zig").DeploymentImpairmentStrategy;
const DeploymentProtectionStrategy = @import("deployment_protection_strategy.zig").DeploymentProtectionStrategy;

/// Set of rules for processing a deployment for a container fleet update.
pub const DeploymentConfiguration = struct {
    /// Determines what actions to take if a deployment fails. If the fleet is
    /// multi-location,
    /// this strategy applies across all fleet locations. With a rollback strategy,
    /// updated
    /// fleet instances are rolled back to the last successful deployment.
    /// Alternatively, you
    /// can maintain a few impaired containers for the purpose of debugging, while
    /// all other
    /// tasks return to the last successful deployment.
    impairment_strategy: ?DeploymentImpairmentStrategy = null,

    /// Sets a minimum level of healthy tasks to maintain during deployment
    /// activity.
    minimum_healthy_percentage: ?i32 = null,

    /// Determines how fleet deployment activity affects active game sessions on the
    /// fleet.
    /// With protection, a deployment honors game session protection, and delays
    /// actions that
    /// would interrupt a protected active game session until the game session ends.
    /// Without
    /// protection, deployment activity can shut down all running tasks, including
    /// active game
    /// sessions, regardless of game session protection.
    protection_strategy: ?DeploymentProtectionStrategy = null,

    pub const json_field_names = .{
        .impairment_strategy = "ImpairmentStrategy",
        .minimum_healthy_percentage = "MinimumHealthyPercentage",
        .protection_strategy = "ProtectionStrategy",
    };
};
