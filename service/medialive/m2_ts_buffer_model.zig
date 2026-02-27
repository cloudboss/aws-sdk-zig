/// M2ts Buffer Model
pub const M2tsBufferModel = enum {
    multiplex,
    none,

    pub const json_field_names = .{
        .multiplex = "MULTIPLEX",
        .none = "NONE",
    };
};
