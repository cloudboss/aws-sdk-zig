const AliasRoutingConfiguration = @import("alias_routing_configuration.zig").AliasRoutingConfiguration;

/// Provides configuration information about a Lambda function
/// [alias](https://docs.aws.amazon.com/lambda/latest/dg/configuration-aliases.html).
pub const AliasConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the alias.
    alias_arn: ?[]const u8,

    /// A description of the alias.
    description: ?[]const u8,

    /// The function version that the alias invokes.
    function_version: ?[]const u8,

    /// The name of the alias.
    name: ?[]const u8,

    /// A unique identifier that changes when you update the alias.
    revision_id: ?[]const u8,

    /// The [routing
    /// configuration](https://docs.aws.amazon.com/lambda/latest/dg/lambda-traffic-shifting-using-aliases.html) of the alias.
    routing_config: ?AliasRoutingConfiguration,
};
