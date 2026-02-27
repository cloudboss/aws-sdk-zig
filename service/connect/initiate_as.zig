pub const InitiateAs = enum {
    connected_to_user,
    completed,

    pub const json_field_names = .{
        .connected_to_user = "CONNECTED_TO_USER",
        .completed = "COMPLETED",
    };
};
