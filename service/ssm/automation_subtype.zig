pub const AutomationSubtype = enum {
    change_request,
    access_request,

    pub const json_field_names = .{
        .change_request = "ChangeRequest",
        .access_request = "AccessRequest",
    };
};
