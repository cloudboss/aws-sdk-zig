const std = @import("std");

pub const ActionGroupSignature = enum {
    amazon_userinput,
    amazon_codeinterpreter,
    anthropic_computer,
    anthropic_bash,
    anthropic_texteditor,

    pub const json_field_names = .{
        .amazon_userinput = "AMAZON.UserInput",
        .amazon_codeinterpreter = "AMAZON.CodeInterpreter",
        .anthropic_computer = "ANTHROPIC.Computer",
        .anthropic_bash = "ANTHROPIC.Bash",
        .anthropic_texteditor = "ANTHROPIC.TextEditor",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .amazon_userinput => "AMAZON.UserInput",
            .amazon_codeinterpreter => "AMAZON.CodeInterpreter",
            .anthropic_computer => "ANTHROPIC.Computer",
            .anthropic_bash => "ANTHROPIC.Bash",
            .anthropic_texteditor => "ANTHROPIC.TextEditor",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
