/// The structure representing the filters supported by a RasterDataCollection.
pub const Filter = struct {
    /// The maximum value of the filter.
    maximum: ?f32,

    /// The minimum value of the filter.
    minimum: ?f32,

    /// The name of the filter.
    name: []const u8,

    /// The type of the filter being used.
    type: []const u8,

    pub const json_field_names = .{
        .maximum = "Maximum",
        .minimum = "Minimum",
        .name = "Name",
        .type = "Type",
    };
};
