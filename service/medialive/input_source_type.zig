/// There are two types of input sources, static and dynamic. If an input source
/// is dynamic you can
/// change the source url of the input dynamically using an input switch action.
/// Currently, two input types
/// support a dynamic url at this time, MP4_FILE and TS_FILE. By default all
/// input sources are static.
pub const InputSourceType = enum {
    static,
    dynamic,

    pub const json_field_names = .{
        .static = "STATIC",
        .dynamic = "DYNAMIC",
    };
};
