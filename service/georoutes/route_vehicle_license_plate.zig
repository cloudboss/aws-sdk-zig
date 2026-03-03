/// License plate information of the vehicle. Currently, only the last character
/// is used where license plate based controlled access is enforced.
pub const RouteVehicleLicensePlate = struct {
    /// The last character of the License Plate.
    last_character: ?[]const u8 = null,

    pub const json_field_names = .{
        .last_character = "LastCharacter",
    };
};
