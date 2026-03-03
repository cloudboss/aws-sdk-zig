const ReservedCapacityInstanceType = @import("reserved_capacity_instance_type.zig").ReservedCapacityInstanceType;

/// A summary of UltraServer resources and their current status.
pub const UltraServerSummary = struct {
    /// The number of available spare instances in the UltraServers.
    available_spare_instance_count: ?i32 = null,

    /// The Amazon EC2 instance type used in the UltraServer.
    instance_type: ReservedCapacityInstanceType,

    /// The number of UltraServers of this type.
    ultra_server_count: ?i32 = null,

    /// The type of UltraServer, such as ml.u-p6e-gb200x72.
    ultra_server_type: []const u8,

    /// The total number of instances across all UltraServers of this type that are
    /// currently in an unhealthy state.
    unhealthy_instance_count: ?i32 = null,

    pub const json_field_names = .{
        .available_spare_instance_count = "AvailableSpareInstanceCount",
        .instance_type = "InstanceType",
        .ultra_server_count = "UltraServerCount",
        .ultra_server_type = "UltraServerType",
        .unhealthy_instance_count = "UnhealthyInstanceCount",
    };
};
