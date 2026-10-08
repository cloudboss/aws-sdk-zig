/// Custom descriptor for user-defined content
pub const CustomDescriptor = struct {
    /// The custom descriptor content, serialized as descriptor payload data.
    data: ?[]const u8 = null,

    pub const json_field_names = .{
        .data = "data",
    };
};
