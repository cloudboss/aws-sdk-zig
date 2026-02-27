/// Used in SdiSource, CreateSdiSourceRequest, UpdateSdiSourceRequest.
pub const SdiSourceMode = enum {
    quadrant,
    interleave,

    pub const json_field_names = .{
        .quadrant = "QUADRANT",
        .interleave = "INTERLEAVE",
    };
};
