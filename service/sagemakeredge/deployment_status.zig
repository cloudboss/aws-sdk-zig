pub const DeploymentStatus = enum {
    success,
    fail,

    pub const json_field_names = .{
        .success = "Success",
        .fail = "Fail",
    };
};
