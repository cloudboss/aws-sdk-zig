/// An object that describes the details of a port range filter.
pub const PortRangeFilter = struct {
    /// The port number the port range begins at.
    begin_inclusive: ?i32,

    /// The port number the port range ends at.
    end_inclusive: ?i32,

    pub const json_field_names = .{
        .begin_inclusive = "beginInclusive",
        .end_inclusive = "endInclusive",
    };
};
