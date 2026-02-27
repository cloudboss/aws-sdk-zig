pub const GetEnvironmentRequest = struct {
    /// The ID of the environment.
    environment_identifier: []const u8,

    pub const json_field_names = .{
        .environment_identifier = "EnvironmentIdentifier",
    };
};
