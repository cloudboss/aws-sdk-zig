/// Describes the root volume for a WorkSpace bundle.
pub const RootStorage = struct {
    /// The size of the root volume.
    capacity: []const u8,

    pub const json_field_names = .{
        .capacity = "Capacity",
    };
};
