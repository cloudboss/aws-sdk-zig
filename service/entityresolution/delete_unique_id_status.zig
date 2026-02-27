pub const DeleteUniqueIdStatus = enum {
    completed,
    accepted,

    pub const json_field_names = .{
        .completed = "COMPLETED",
        .accepted = "ACCEPTED",
    };
};
