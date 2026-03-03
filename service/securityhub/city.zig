/// Information about a city.
pub const City = struct {
    /// The name of the city.
    city_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .city_name = "CityName",
    };
};
