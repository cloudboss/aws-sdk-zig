/// The vehicle license plate.
pub const IsolineVehicleLicensePlate = struct {
    /// The last character of the License Plate.
    last_character: ?[]const u8 = null,

    pub const json_field_names = .{
        .last_character = "LastCharacter",
    };
};
