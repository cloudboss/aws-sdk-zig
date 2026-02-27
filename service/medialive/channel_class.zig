/// A standard channel has two encoding pipelines and a single pipeline channel
/// only has one.
pub const ChannelClass = enum {
    standard,
    single_pipeline,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .single_pipeline = "SINGLE_PIPELINE",
    };
};
