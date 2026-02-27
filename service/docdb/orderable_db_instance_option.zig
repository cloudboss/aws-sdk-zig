const AvailabilityZone = @import("availability_zone.zig").AvailabilityZone;

/// The options that are available for an instance.
pub const OrderableDBInstanceOption = struct {
    /// A list of Availability Zones for an instance.
    availability_zones: ?[]const AvailabilityZone,

    /// The instance class for an instance.
    db_instance_class: ?[]const u8,

    /// The engine type of an instance.
    engine: ?[]const u8,

    /// The engine version of an instance.
    engine_version: ?[]const u8,

    /// The license model for an instance.
    license_model: ?[]const u8,

    /// The storage type to associate with the DB cluster
    storage_type: ?[]const u8,

    /// Indicates whether an instance is in a virtual private cloud (VPC).
    vpc: ?bool,
};
