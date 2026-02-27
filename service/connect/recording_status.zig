pub const RecordingStatus = enum {
    available,
    deleted,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .deleted = "DELETED",
    };
};
