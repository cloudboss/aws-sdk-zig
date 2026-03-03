/// A programming language supported by the platform.
pub const PlatformProgrammingLanguage = struct {
    /// The name of the programming language.
    name: ?[]const u8 = null,

    /// The version of the programming language.
    version: ?[]const u8 = null,
};
