pub const TargetOptions = enum {
    /// INPUT
    input,
    /// OUTPUT
    output,

    pub const json_field_names = .{
        .input = "INPUT",
        .output = "OUTPUT",
    };
};
