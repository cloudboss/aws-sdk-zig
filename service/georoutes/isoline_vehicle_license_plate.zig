/// License plate information used in regions where road access or routing
/// restrictions are based on license plate numbers.
pub const IsolineVehicleLicensePlate = struct {
    /// The last character of the vehicle's license plate. Used to determine road
    /// access restrictions in regions with license plate-based traffic management
    /// systems.
    last_character: ?[]const u8 = null,

    pub const json_field_names = .{
        .last_character = "LastCharacter",
    };
};
