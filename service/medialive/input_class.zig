/// A standard input has two sources and a single pipeline input only has one.
pub const InputClass = enum {
    standard,
    single_pipeline,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .single_pipeline = "SINGLE_PIPELINE",
    };
};
