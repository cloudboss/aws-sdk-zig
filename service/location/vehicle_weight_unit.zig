pub const VehicleWeightUnit = enum {
    kilograms,
    pounds,

    pub const json_field_names = .{
        .kilograms = "Kilograms",
        .pounds = "Pounds",
    };
};
