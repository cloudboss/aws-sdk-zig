pub const Watcher = struct {
    email: []const u8,

    job_title: ?[]const u8 = null,

    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .email = "email",
        .job_title = "jobTitle",
        .name = "name",
    };
};
