/// Specifies the connections used by a job.
pub const ConnectionsList = struct {
    /// A list of connections used by the job.
    connections: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .connections = "Connections",
    };
};
