pub const FileUseCase = enum {
    code_interpreter,
    chat,

    pub const json_field_names = .{
        .code_interpreter = "CODE_INTERPRETER",
        .chat = "CHAT",
    };
};
