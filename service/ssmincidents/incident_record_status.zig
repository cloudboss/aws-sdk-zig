pub const IncidentRecordStatus = enum {
    open,
    resolved,

    pub const json_field_names = .{
        .open = "OPEN",
        .resolved = "RESOLVED",
    };
};
