pub const ApplicationAttribute = enum {
    launch_parameters,
    working_directory,

    pub const json_field_names = .{
        .launch_parameters = "LAUNCH_PARAMETERS",
        .working_directory = "WORKING_DIRECTORY",
    };
};
