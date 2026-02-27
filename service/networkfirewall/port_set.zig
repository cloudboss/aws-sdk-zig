/// A set of port ranges for use in the rules in a rule group.
pub const PortSet = struct {
    /// The set of port ranges.
    definition: ?[]const []const u8,

    pub const json_field_names = .{
        .definition = "Definition",
    };
};
