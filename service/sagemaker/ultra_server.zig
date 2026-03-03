const UltraServerHealthStatus = @import("ultra_server_health_status.zig").UltraServerHealthStatus;
const ReservedCapacityInstanceType = @import("reserved_capacity_instance_type.zig").ReservedCapacityInstanceType;

/// Represents a high-performance compute server used for distributed training
/// in SageMaker AI. An UltraServer consists of multiple instances within a
/// shared NVLink interconnect domain.
pub const UltraServer = struct {
    /// The name of the Availability Zone where the UltraServer is provisioned.
    availability_zone: []const u8,

    /// The number of instances currently available for use in this UltraServer.
    available_instance_count: ?i32 = null,

    /// The number of available spare instances in the UltraServer.
    available_spare_instance_count: ?i32 = null,

    /// The number of spare instances configured for this UltraServer to provide
    /// enhanced resiliency.
    configured_spare_instance_count: ?i32 = null,

    /// The overall health status of the UltraServer.
    health_status: ?UltraServerHealthStatus = null,

    /// The Amazon EC2 instance type used in the UltraServer.
    instance_type: ReservedCapacityInstanceType,

    /// The number of instances currently in use in this UltraServer.
    in_use_instance_count: ?i32 = null,

    /// The total number of instances in this UltraServer.
    total_instance_count: i32,

    /// The unique identifier for the UltraServer.
    ultra_server_id: []const u8,

    /// The type of UltraServer, such as ml.u-p6e-gb200x72.
    ultra_server_type: []const u8,

    /// The number of instances in this UltraServer that are currently in an
    /// unhealthy state.
    unhealthy_instance_count: ?i32 = null,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .available_instance_count = "AvailableInstanceCount",
        .available_spare_instance_count = "AvailableSpareInstanceCount",
        .configured_spare_instance_count = "ConfiguredSpareInstanceCount",
        .health_status = "HealthStatus",
        .instance_type = "InstanceType",
        .in_use_instance_count = "InUseInstanceCount",
        .total_instance_count = "TotalInstanceCount",
        .ultra_server_id = "UltraServerId",
        .ultra_server_type = "UltraServerType",
        .unhealthy_instance_count = "UnhealthyInstanceCount",
    };
};
