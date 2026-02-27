/// Used in SdiSource, CreateSdiSourceRequest, UpdateSdiSourceRequest.
pub const SdiSourceType = enum {
    single,
    quad,

    pub const json_field_names = .{
        .single = "SINGLE",
        .quad = "QUAD",
    };
};
