/// An HTTP error resulting from creating a vehicle.
pub const CreateVehicleError = struct {
    /// An HTTP error code.
    code: ?[]const u8 = null,

    /// A description of the HTTP error.
    message: ?[]const u8 = null,

    /// The ID of the vehicle with the error.
    vehicle_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
        .vehicle_name = "vehicleName",
    };
};
