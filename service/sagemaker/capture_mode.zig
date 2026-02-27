pub const CaptureMode = enum {
    input,
    output,
    input_and_output,

    pub const json_field_names = .{
        .input = "INPUT",
        .output = "OUTPUT",
        .input_and_output = "INPUT_AND_OUTPUT",
    };
};
