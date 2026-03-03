/// Information about a created vehicle.
pub const CreateVehicleResponseItem = struct {
    /// The ARN of the created vehicle.
    arn: ?[]const u8 = null,

    /// The ARN of a created or validated Amazon Web Services IoT thing.
    thing_arn: ?[]const u8 = null,

    /// The unique ID of the vehicle to create.
    vehicle_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .thing_arn = "thingArn",
        .vehicle_name = "vehicleName",
    };
};
