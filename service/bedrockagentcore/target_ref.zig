/// A reference to a gateway target.
pub const TargetRef = struct {
    /// The name of the gateway target.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};
