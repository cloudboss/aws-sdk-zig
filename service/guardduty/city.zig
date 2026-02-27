/// Contains information about the city associated with the IP address.
pub const City = struct {
    /// The city name of the remote IP address.
    city_name: ?[]const u8,

    pub const json_field_names = .{
        .city_name = "CityName",
    };
};
