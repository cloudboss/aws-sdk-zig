/// Represents an action to add a Reserved Instance to a bill scenario.
pub const AddReservedInstanceAction = struct {
    /// The number of instances to add for this Reserved Instance offering.
    instance_count: ?i32,

    /// The ID of the Reserved Instance offering to add. For more information, see [
    /// DescribeReservedInstancesOfferings](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeReservedInstancesOfferings.html).
    reserved_instances_offering_id: ?[]const u8,

    pub const json_field_names = .{
        .instance_count = "instanceCount",
        .reserved_instances_offering_id = "reservedInstancesOfferingId",
    };
};
