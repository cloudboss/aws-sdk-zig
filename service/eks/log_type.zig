pub const LogType = enum {
    api,
    audit,
    authenticator,
    controller_manager,
    scheduler,

    pub const json_field_names = .{
        .api = "API",
        .audit = "AUDIT",
        .authenticator = "AUTHENTICATOR",
        .controller_manager = "CONTROLLER_MANAGER",
        .scheduler = "SCHEDULER",
    };
};
