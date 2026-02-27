/// Input Filter
pub const InputFilter = enum {
    auto,
    disabled,
    forced,

    pub const json_field_names = .{
        .auto = "AUTO",
        .disabled = "DISABLED",
        .forced = "FORCED",
    };
};
