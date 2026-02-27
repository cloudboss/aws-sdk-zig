pub const BounceType = enum {
    undetermined,
    transient,
    permanent,

    pub const json_field_names = .{
        .undetermined = "UNDETERMINED",
        .transient = "TRANSIENT",
        .permanent = "PERMANENT",
    };
};
