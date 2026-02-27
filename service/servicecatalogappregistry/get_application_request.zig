pub const GetApplicationRequest = struct {
    /// The name, ID, or ARN
    /// of the application.
    application: []const u8,

    pub const json_field_names = .{
        .application = "application",
    };
};
