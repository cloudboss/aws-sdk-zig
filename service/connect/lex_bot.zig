/// Configuration information of an Amazon Lex bot.
pub const LexBot = struct {
    /// The Amazon Web Services Region where the Amazon Lex bot was created.
    lex_region: []const u8,

    /// The name of the Amazon Lex bot.
    name: []const u8,

    pub const json_field_names = .{
        .lex_region = "LexRegion",
        .name = "Name",
    };
};
