const aws = @import("aws");

/// Contains metadata about a serverless function associated with a covered
/// resource.
pub const ServerlessFunctionMetadata = struct {
    /// The tags associated with the serverless function.
    function_tags: ?[]const aws.map.StringMapEntry = null,

    /// The runtime of the serverless function.
    runtime: ?[]const u8 = null,

    /// The name of the serverless function.
    serverless_function_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .function_tags = "functionTags",
        .runtime = "runtime",
        .serverless_function_name = "serverlessFunctionName",
    };
};
