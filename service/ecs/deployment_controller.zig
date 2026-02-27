const DeploymentControllerType = @import("deployment_controller_type.zig").DeploymentControllerType;

/// The deployment controller to use for the service.
pub const DeploymentController = struct {
    /// The deployment controller type to use.
    ///
    /// The deployment controller is the mechanism that determines how tasks are
    /// deployed for
    /// your service. The valid options are:
    ///
    /// * ECS
    ///
    /// When you create a service which uses the `ECS` deployment
    /// controller, you can choose between the following deployment strategies:
    ///
    /// * `ROLLING`: When you create a service which uses the
    /// *rolling update* (`ROLLING`)
    /// deployment strategy, the Amazon ECS service scheduler replaces the
    /// currently running tasks with new tasks. The number of tasks that Amazon
    /// ECS adds or removes from the service during a rolling update is
    /// controlled by the service deployment configuration.
    ///
    /// Rolling update deployments are best suited for the following
    /// scenarios:
    ///
    /// * Gradual service updates: You need to update your service
    /// incrementally without taking the entire service offline at
    /// once.
    ///
    /// * Limited resource requirements: You want to avoid the
    /// additional resource costs of running two complete environments
    /// simultaneously (as required by blue/green deployments).
    ///
    /// * Acceptable deployment time: Your application can tolerate a
    /// longer deployment process, as rolling updates replace tasks one
    /// by one.
    ///
    /// * No need for instant roll back: Your service can tolerate a
    /// rollback process that takes minutes rather than seconds.
    ///
    /// * Simple deployment process: You prefer a straightforward
    /// deployment approach without the complexity of managing multiple
    /// environments, target groups, and listeners.
    ///
    /// * No load balancer requirement: Your service doesn't use or
    /// require a load balancer, Application Load Balancer, Network Load
    /// Balancer, or Service Connect (which are required for blue/green
    /// deployments).
    ///
    /// * Stateful applications: Your application maintains state that
    /// makes it difficult to run two parallel environments.
    ///
    /// * Cost sensitivity: You want to minimize deployment costs by not
    /// running duplicate environments during deployment.
    ///
    /// Rolling updates are the default deployment strategy for services and
    /// provide a balance between deployment safety and resource efficiency for
    /// many common application scenarios.
    ///
    /// * `BLUE_GREEN`: A *blue/green* deployment
    /// strategy (`BLUE_GREEN`) is a release methodology that reduces
    /// downtime and risk by running two identical production environments
    /// called blue and green. With Amazon ECS blue/green deployments, you can
    /// validate new service revisions before directing production traffic to
    /// them. This approach provides a safer way to deploy changes with the
    /// ability to quickly roll back if needed.
    ///
    /// Amazon ECS blue/green deployments are best suited for the following
    /// scenarios:
    ///
    /// * Service validation: When you need to validate new service
    /// revisions before directing production traffic to them
    ///
    /// * Zero downtime: When your service requires zero-downtime
    /// deployments
    ///
    /// * Instant roll back: When you need the ability to quickly roll
    /// back if issues are detected
    ///
    /// * Load balancer requirement: When your service uses Application
    /// Load Balancer, Network Load Balancer, or Service Connect
    ///
    /// * External
    ///
    /// Use a third-party deployment controller.
    ///
    /// * Blue/green deployment (powered by CodeDeploy)
    ///
    /// CodeDeploy installs an updated version of the application as a new
    /// replacement task set and reroutes production traffic from the original
    /// application task set to the replacement task set. The original task set is
    /// terminated after a successful deployment. Use this deployment controller to
    /// verify a new deployment of a service before sending production traffic to
    /// it.
    type: DeploymentControllerType,

    pub const json_field_names = .{
        .type = "type",
    };
};
