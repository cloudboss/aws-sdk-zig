pub const Status = enum {
    start_expired,
    not_started,
    started,
    starting,
    stopped,
    stopping,
    setting_up_instance,
    failed_instance_creation,
    failed_starting_gui_session,
    failed_stopping_gui_session,

    pub const json_field_names = .{
        .start_expired = "StartExpired",
        .not_started = "NotStarted",
        .started = "Started",
        .starting = "Starting",
        .stopped = "Stopped",
        .stopping = "Stopping",
        .setting_up_instance = "SettingUpInstance",
        .failed_instance_creation = "FailedInstanceCreation",
        .failed_starting_gui_session = "FailedStartingGUISession",
        .failed_stopping_gui_session = "FailedStoppingGUISession",
    };
};
