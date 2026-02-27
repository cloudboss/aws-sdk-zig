const CustomerManagedFleetConfiguration = @import("customer_managed_fleet_configuration.zig").CustomerManagedFleetConfiguration;
const ServiceManagedEc2FleetConfiguration = @import("service_managed_ec_2_fleet_configuration.zig").ServiceManagedEc2FleetConfiguration;

/// Fleet configuration details.
pub const FleetConfiguration = union(enum) {
    /// The customer managed fleets within a fleet configuration.
    customer_managed: ?CustomerManagedFleetConfiguration,
    /// The service managed Amazon EC2 instances for a fleet configuration.
    service_managed_ec_2: ?ServiceManagedEc2FleetConfiguration,

    pub const json_field_names = .{
        .customer_managed = "customerManaged",
        .service_managed_ec_2 = "serviceManagedEc2",
    };
};
