/// Contains details of the response from code interpreter.
pub const OutputFile = struct {
    /// The byte count of files that contains response from code interpreter.
    bytes: ?[]const u8,

    /// The name of the file containing response from code interpreter.
    name: ?[]const u8,

    /// The type of file that contains response from the code interpreter.
    type: ?[]const u8,

    pub const json_field_names = .{
        .bytes = "bytes",
        .name = "name",
        .type = "type",
    };
};
