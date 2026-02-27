/// An HTTP error resulting from updating the description for a vehicle.
pub const UpdateVehicleError = struct {
    /// The relevant HTTP error code (400+).
    code: i32 = 0,

    /// A message associated with the error.
    message: ?[]const u8,

    /// The ID of the vehicle with the error.
    vehicle_name: ?[]const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
        .vehicle_name = "vehicleName",
    };
};
