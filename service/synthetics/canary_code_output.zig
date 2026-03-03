const Dependency = @import("dependency.zig").Dependency;

/// This structure contains information about the canary's Lambda handler and
/// where its code is stored by CloudWatch Synthetics.
pub const CanaryCodeOutput = struct {
    /// `BlueprintTypes` is a list of templates that enable simplified canary
    /// creation. You can create canaries for common monitoring scenarios by
    /// providing only a JSON configuration file instead of writing custom scripts.
    /// The only supported value is `multi-checks`.
    ///
    /// Multi-checks monitors HTTP/DNS/SSL/TCP endpoints with built-in
    /// authentication schemes (Basic, API Key, OAuth, SigV4) and assertion
    /// capabilities. When you specify `BlueprintTypes`, the Handler field cannot be
    /// specified since the blueprint provides a pre-defined entry point.
    ///
    /// `BlueprintTypes` is supported only on canaries for syn-nodejs-3.0 runtime or
    /// later.
    blueprint_types: ?[]const []const u8 = null,

    /// A list of dependencies that are used for running this canary. The
    /// dependencies are specified as a key-value pair, where the key is the type of
    /// dependency and the value is the dependency reference.
    dependencies: ?[]const Dependency = null,

    /// The entry point to use for the source code when running the canary.
    ///
    /// This field is required when you don't specify `BlueprintTypes` and is not
    /// allowed when you specify `BlueprintTypes`.
    handler: ?[]const u8 = null,

    /// The ARN of the Lambda layer where Synthetics stores the canary script code.
    source_location_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .blueprint_types = "BlueprintTypes",
        .dependencies = "Dependencies",
        .handler = "Handler",
        .source_location_arn = "SourceLocationArn",
    };
};
