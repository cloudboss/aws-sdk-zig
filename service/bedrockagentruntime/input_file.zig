const FileSource = @import("file_source.zig").FileSource;
const FileUseCase = @import("file_use_case.zig").FileUseCase;

/// Contains details of the source files.
pub const InputFile = struct {
    /// The name of the source file.
    name: []const u8,

    /// Specifies where the files are located.
    source: FileSource,

    /// Specifies how the source files will be used by the code interpreter.
    use_case: FileUseCase,

    pub const json_field_names = .{
        .name = "name",
        .source = "source",
        .use_case = "useCase",
    };
};
