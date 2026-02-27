pub const SoftwareSetUpdateSchedule = enum {
    use_maintenance_window,
    apply_immediately,

    pub const json_field_names = .{
        .use_maintenance_window = "USE_MAINTENANCE_WINDOW",
        .apply_immediately = "APPLY_IMMEDIATELY",
    };
};
