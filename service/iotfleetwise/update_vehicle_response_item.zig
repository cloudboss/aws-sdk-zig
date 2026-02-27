/// Information about the updated vehicle.
pub const UpdateVehicleResponseItem = struct {
    /// The Amazon Resource Name (ARN) of the updated vehicle.
    arn: ?[]const u8,

    /// The unique ID of the updated vehicle.
    vehicle_name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .vehicle_name = "vehicleName",
    };
};
