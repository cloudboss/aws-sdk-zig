pub const RegistrationStatus = enum {
    complete,
    incomplete,

    pub const json_field_names = .{
        .complete = "COMPLETE",
        .incomplete = "INCOMPLETE",
    };
};
