pub const AddOnType = enum {
    auto_snapshot,
    stop_instance_on_idle,

    pub const json_field_names = .{
        .auto_snapshot = "AutoSnapshot",
        .stop_instance_on_idle = "StopInstanceOnIdle",
    };
};
