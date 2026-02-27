pub const ActionGroupSignature = enum {
    amazon_userinput,
    amazon_codeinterpreter,
    anthropic_computer,
    anthropic_bash,
    anthropic_texteditor,

    pub const json_field_names = .{
        .amazon_userinput = "AMAZON_USERINPUT",
        .amazon_codeinterpreter = "AMAZON_CODEINTERPRETER",
        .anthropic_computer = "ANTHROPIC_COMPUTER",
        .anthropic_bash = "ANTHROPIC_BASH",
        .anthropic_texteditor = "ANTHROPIC_TEXTEDITOR",
    };
};
