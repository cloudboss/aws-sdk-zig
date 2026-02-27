pub const TriggerResourceUpdateOn = enum {
    any_change,
    file_change,

    pub const json_field_names = .{
        .any_change = "ANY_CHANGE",
        .file_change = "FILE_CHANGE",
    };
};
