/// Contains metadata about a container registry associated with a covered
/// resource.
pub const ContainerRegistryMetadata = struct {
    /// The name of the container registry.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
    };
};
