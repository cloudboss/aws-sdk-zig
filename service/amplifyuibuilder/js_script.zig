pub const JSScript = enum {
    jsx,
    tsx,
    js,

    pub const json_field_names = .{
        .jsx = "JSX",
        .tsx = "TSX",
        .js = "JS",
    };
};
