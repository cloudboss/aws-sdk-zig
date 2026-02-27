pub const ConditionType = enum {
    before_entry,
    on_success,

    pub const json_field_names = .{
        .before_entry = "BEFORE_ENTRY",
        .on_success = "ON_SUCCESS",
    };
};
