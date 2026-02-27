pub const OutputType = enum {
    sdl,
    json,

    pub const json_field_names = .{
        .sdl = "SDL",
        .json = "JSON",
    };
};
