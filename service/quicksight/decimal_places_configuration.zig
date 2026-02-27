/// The option that determines the decimal places configuration.
pub const DecimalPlacesConfiguration = struct {
    /// The values of the decimal places.
    decimal_places: i64,

    pub const json_field_names = .{
        .decimal_places = "DecimalPlaces",
    };
};
