/// Av1 Timecode Insertion Behavior
pub const Av1TimecodeInsertionBehavior = enum {
    disabled,
    metadata_obu,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .metadata_obu = "METADATA_OBU",
    };
};
