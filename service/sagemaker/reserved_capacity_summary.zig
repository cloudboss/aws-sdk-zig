const ReservedCapacityInstanceType = @import("reserved_capacity_instance_type.zig").ReservedCapacityInstanceType;
const ReservedCapacityType = @import("reserved_capacity_type.zig").ReservedCapacityType;
const ReservedCapacityStatus = @import("reserved_capacity_status.zig").ReservedCapacityStatus;

/// Details of a reserved capacity for the training plan.
///
/// For more information about how to reserve GPU capacity for your SageMaker
/// HyperPod clusters using Amazon SageMaker Training Plan, see `
/// [CreateTrainingPlan](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateTrainingPlan.html) `.
pub const ReservedCapacitySummary = struct {
    /// The availability zone for the reserved capacity.
    availability_zone: ?[]const u8 = null,

    /// The number of whole hours in the total duration for this reserved capacity.
    duration_hours: ?i64 = null,

    /// The additional minutes beyond whole hours in the total duration for this
    /// reserved capacity.
    duration_minutes: ?i64 = null,

    /// The end time of the reserved capacity.
    end_time: ?i64 = null,

    /// The instance type for the reserved capacity.
    instance_type: ReservedCapacityInstanceType,

    /// The Amazon Resource Name (ARN); of the reserved capacity.
    reserved_capacity_arn: []const u8,

    /// The type of reserved capacity.
    reserved_capacity_type: ?ReservedCapacityType = null,

    /// The start time of the reserved capacity.
    start_time: ?i64 = null,

    /// The current status of the reserved capacity.
    status: ReservedCapacityStatus,

    /// The total number of instances in the reserved capacity.
    total_instance_count: i32,

    /// The number of UltraServers included in this reserved capacity.
    ultra_server_count: ?i32 = null,

    /// The type of UltraServer included in this reserved capacity, such as
    /// ml.u-p6e-gb200x72.
    ultra_server_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .duration_hours = "DurationHours",
        .duration_minutes = "DurationMinutes",
        .end_time = "EndTime",
        .instance_type = "InstanceType",
        .reserved_capacity_arn = "ReservedCapacityArn",
        .reserved_capacity_type = "ReservedCapacityType",
        .start_time = "StartTime",
        .status = "Status",
        .total_instance_count = "TotalInstanceCount",
        .ultra_server_count = "UltraServerCount",
        .ultra_server_type = "UltraServerType",
    };
};
