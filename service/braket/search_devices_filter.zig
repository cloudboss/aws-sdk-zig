/// The filter used to search for devices.
pub const SearchDevicesFilter = struct {
    /// The name of the device parameter to filter based on. Only `deviceArn` filter
    /// name is currently supported.
    name: []const u8,

    /// The values used to filter devices based on the filter name.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
