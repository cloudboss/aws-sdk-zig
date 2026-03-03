const EnvironmentImage = @import("environment_image.zig").EnvironmentImage;
const LanguageType = @import("language_type.zig").LanguageType;

/// A set of Docker images that are related by programming language and are
/// managed by
/// CodeBuild.
pub const EnvironmentLanguage = struct {
    /// The list of Docker images that are related by the specified programming
    /// language.
    images: ?[]const EnvironmentImage = null,

    /// The programming language for the Docker images.
    language: ?LanguageType = null,

    pub const json_field_names = .{
        .images = "images",
        .language = "language",
    };
};
