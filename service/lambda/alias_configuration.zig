const AliasRoutingConfiguration = @import("alias_routing_configuration.zig").AliasRoutingConfiguration;

/// Provides configuration information about a Lambda function
/// [alias](https://docs.aws.amazon.com/lambda/latest/dg/configuration-aliases.html).
pub const AliasConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the alias.
    alias_arn: ?[]const u8 = null,

    /// A description of the alias.
    description: ?[]const u8 = null,

    /// The function version that the alias invokes.
    function_version: ?[]const u8 = null,

    /// The name of the alias.
    name: ?[]const u8 = null,

    /// A unique identifier that changes when you update the alias.
    revision_id: ?[]const u8 = null,

    /// The [routing
    /// configuration](https://docs.aws.amazon.com/lambda/latest/dg/lambda-traffic-shifting-using-aliases.html) of the alias.
    routing_config: ?AliasRoutingConfiguration = null,

    pub const json_field_names = .{
        .alias_arn = "AliasArn",
        .description = "Description",
        .function_version = "FunctionVersion",
        .name = "Name",
        .revision_id = "RevisionId",
        .routing_config = "RoutingConfig",
    };
};
