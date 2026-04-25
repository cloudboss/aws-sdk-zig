const ReservedCapacityInstanceType = @import("reserved_capacity_instance_type.zig").ReservedCapacityInstanceType;
const ReservedCapacityType = @import("reserved_capacity_type.zig").ReservedCapacityType;

/// Details about a reserved capacity offering for a training plan offering.
///
/// For more information about how to reserve GPU capacity for your SageMaker
/// HyperPod clusters using Amazon SageMaker Training Plan, see `
/// [CreateTrainingPlan](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateTrainingPlan.html) `.
pub const ReservedCapacityOffering = struct {
    /// The availability zone for the reserved capacity offering.
    availability_zone: ?[]const u8 = null,

    /// The number of whole hours in the total duration for this reserved capacity
    /// offering.
    duration_hours: ?i64 = null,

    /// The additional minutes beyond whole hours in the total duration for this
    /// reserved capacity offering.
    duration_minutes: ?i64 = null,

    /// The end time of the reserved capacity offering.
    end_time: ?i64 = null,

    /// The end time of the extension for the reserved capacity offering.
    extension_end_time: ?i64 = null,

    /// The start time of the extension for the reserved capacity offering.
    extension_start_time: ?i64 = null,

    /// The number of instances in the reserved capacity offering.
    instance_count: i32,

    /// The instance type for the reserved capacity offering.
    instance_type: ReservedCapacityInstanceType,

    /// The type of reserved capacity offering.
    reserved_capacity_type: ?ReservedCapacityType = null,

    /// The start time of the reserved capacity offering.
    start_time: ?i64 = null,

    /// The number of UltraServers included in this reserved capacity offering.
    ultra_server_count: ?i32 = null,

    /// The type of UltraServer included in this reserved capacity offering, such as
    /// ml.u-p6e-gb200x72.
    ultra_server_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .duration_hours = "DurationHours",
        .duration_minutes = "DurationMinutes",
        .end_time = "EndTime",
        .extension_end_time = "ExtensionEndTime",
        .extension_start_time = "ExtensionStartTime",
        .instance_count = "InstanceCount",
        .instance_type = "InstanceType",
        .reserved_capacity_type = "ReservedCapacityType",
        .start_time = "StartTime",
        .ultra_server_count = "UltraServerCount",
        .ultra_server_type = "UltraServerType",
    };
};
