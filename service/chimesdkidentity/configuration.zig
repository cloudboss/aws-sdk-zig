const LexConfiguration = @import("lex_configuration.zig").LexConfiguration;

/// A structure that contains configuration data.
pub const Configuration = struct {
    /// The configuration for an Amazon Lex V2 bot.
    lex: LexConfiguration,

    pub const json_field_names = .{
        .lex = "Lex",
    };
};
