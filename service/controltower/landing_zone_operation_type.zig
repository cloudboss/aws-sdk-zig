pub const LandingZoneOperationType = enum {
    delete,
    create,
    update,
    reset,

    pub const json_field_names = .{
        .delete = "DELETE",
        .create = "CREATE",
        .update = "UPDATE",
        .reset = "RESET",
    };
};
