const aws = @import("aws");

/// A function's environment variable settings. You can use environment
/// variables to adjust your function's behavior without updating code. An
/// environment variable is a pair of strings that are stored in a function's
/// version-specific configuration.
pub const Environment = struct {
    /// Environment variable key-value pairs. For more information, see [Using
    /// Lambda environment
    /// variables](https://docs.aws.amazon.com/lambda/latest/dg/configuration-envvars.html).
    variables: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .variables = "Variables",
    };
};
