/// The physical capacity of the Amazon Web Services Snow Family device.
pub const Capacity = struct {
    /// The amount of capacity available for use on the device.
    available: ?i64 = null,

    /// The name of the type of capacity, such as memory.
    name: ?[]const u8 = null,

    /// The total capacity on the device.
    total: ?i64 = null,

    /// The unit of measure for the type of capacity.
    unit: ?[]const u8 = null,

    /// The amount of capacity used on the device.
    used: ?i64 = null,

    pub const json_field_names = .{
        .available = "available",
        .name = "name",
        .total = "total",
        .unit = "unit",
        .used = "used",
    };
};
