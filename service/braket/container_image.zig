/// The container image used to create an Amazon Braket hybrid job.
pub const ContainerImage = struct {
    /// The URI locating the container image.
    uri: []const u8,

    pub const json_field_names = .{
        .uri = "uri",
    };
};
