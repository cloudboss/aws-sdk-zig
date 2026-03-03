/// Contains information about the status of the docker server.
pub const DockerServerStatus = struct {
    /// A message associated with the status of a docker server.
    message: ?[]const u8 = null,

    /// The status of the docker server.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "message",
        .status = "status",
    };
};
