const RoutingStrategy = @import("routing_strategy.zig").RoutingStrategy;

/// Properties that describe an alias resource.
///
/// **Related actions**
///
/// [All APIs by
/// task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
pub const Alias = struct {
    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// that is assigned to a Amazon GameLift Servers alias resource and uniquely
    /// identifies it. ARNs are unique across all Regions. Format is
    /// `arn:aws:gamelift:::alias/alias-a1234567-b8c9-0d1e-2fa3-b45c6d7e8912`. In a
    /// GameLift alias ARN, the resource ID matches the alias ID value.
    alias_arn: ?[]const u8,

    /// A unique identifier for the alias. Alias IDs are unique within a Region.
    alias_id: ?[]const u8,

    /// A time stamp indicating when this data object was created. Format is a
    /// number expressed in Unix time as milliseconds (for example
    /// `"1469498468.057"`).
    creation_time: ?i64,

    /// A human-readable description of an alias.
    description: ?[]const u8,

    /// The time that this data object was last modified. Format is a number
    /// expressed in Unix time as milliseconds (for example `"1469498468.057"`).
    last_updated_time: ?i64,

    /// A descriptive label that is associated with an alias. Alias names do not
    /// need to be unique.
    name: ?[]const u8,

    /// The routing configuration, including routing type and fleet target, for the
    /// alias.
    routing_strategy: ?RoutingStrategy,

    pub const json_field_names = .{
        .alias_arn = "AliasArn",
        .alias_id = "AliasId",
        .creation_time = "CreationTime",
        .description = "Description",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .routing_strategy = "RoutingStrategy",
    };
};
