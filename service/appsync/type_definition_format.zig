pub const TypeDefinitionFormat = enum {
    sdl,
    json,

    pub const json_field_names = .{
        .sdl = "SDL",
        .json = "JSON",
    };
};
