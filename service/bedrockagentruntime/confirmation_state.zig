pub const ConfirmationState = enum {
    confirm,
    deny,

    pub const json_field_names = .{
        .confirm = "CONFIRM",
        .deny = "DENY",
    };
};
