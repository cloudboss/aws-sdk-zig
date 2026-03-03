/// The vehicle License Plate.
pub const RouteMatrixVehicleLicensePlate = struct {
    /// The last character of the License Plate.
    last_character: ?[]const u8 = null,

    pub const json_field_names = .{
        .last_character = "LastCharacter",
    };
};
