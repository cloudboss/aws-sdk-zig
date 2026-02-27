const BalancingStrategy = @import("balancing_strategy.zig").BalancingStrategy;
const GameServerProtectionPolicy = @import("game_server_protection_policy.zig").GameServerProtectionPolicy;
const InstanceDefinition = @import("instance_definition.zig").InstanceDefinition;
const GameServerGroupStatus = @import("game_server_group_status.zig").GameServerGroupStatus;
const GameServerGroupAction = @import("game_server_group_action.zig").GameServerGroupAction;

/// Properties that describe a game
/// server group resource. A game server group manages certain properties
/// related to a
/// corresponding Amazon EC2 Auto Scaling group.
///
/// A game server group is created by a successful call to
/// `CreateGameServerGroup` and deleted by calling
/// `DeleteGameServerGroup`. Game server group activity can be temporarily
/// suspended and resumed by calling `SuspendGameServerGroup` and
/// `ResumeGameServerGroup`, respectively.
pub const GameServerGroup = struct {
    /// A generated unique ID for the Amazon EC2 Auto Scaling group that is
    /// associated with this
    /// game server group.
    auto_scaling_group_arn: ?[]const u8,

    /// Indicates how Amazon GameLift Servers FleetIQ balances the use of Spot
    /// Instances and On-Demand Instances in the
    /// game server group. Method options include the following:
    ///
    /// * `SPOT_ONLY` - Only Spot Instances are used in the game server group. If
    ///   Spot
    /// Instances are unavailable or not viable for game hosting, the game server
    /// group
    /// provides no hosting capacity until Spot Instances can again be used. Until
    /// then,
    /// no new instances are started, and the existing nonviable Spot Instances are
    /// terminated (after current gameplay ends) and are not replaced.
    ///
    /// * `SPOT_PREFERRED` - (default value) Spot Instances are used whenever
    ///   available in
    /// the game server group. If Spot Instances are unavailable, the game server
    /// group
    /// continues to provide hosting capacity by falling back to On-Demand
    /// Instances.
    /// Existing nonviable Spot Instances are terminated (after current gameplay
    /// ends)
    /// and are replaced with new On-Demand Instances.
    ///
    /// * `ON_DEMAND_ONLY` - Only On-Demand Instances are used in the game
    /// server group. No Spot Instances are used, even when available, while this
    /// balancing strategy is in force.
    balancing_strategy: ?BalancingStrategy,

    /// A time stamp indicating when this data object was created. Format is a
    /// number expressed in Unix time as milliseconds (for example
    /// `"1469498468.057"`).
    creation_time: ?i64,

    /// A generated unique ID for the game server group.
    game_server_group_arn: ?[]const u8,

    /// A developer-defined identifier for the game server group. The name is unique
    /// for each
    /// Region in each Amazon Web Services account.
    game_server_group_name: ?[]const u8,

    /// A flag that indicates whether instances in the game server group are
    /// protected
    /// from early termination. Unprotected instances that have active game servers
    /// running might
    /// be terminated during a scale-down event, causing players to be dropped from
    /// the game.
    /// Protected instances cannot be terminated while there are active game servers
    /// running except
    /// in the event of a forced game server group deletion (see ). An exception to
    /// this is with Spot
    /// Instances, which can be terminated by Amazon Web Services regardless of
    /// protection status.
    game_server_protection_policy: ?GameServerProtectionPolicy,

    /// The set of Amazon EC2 instance types that Amazon GameLift Servers FleetIQ
    /// can use when balancing and automatically
    /// scaling instances in the corresponding Auto Scaling group.
    instance_definitions: ?[]const InstanceDefinition,

    /// A timestamp that indicates when this game server group was last updated.
    last_updated_time: ?i64,

    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// for an IAM role that
    /// allows Amazon GameLift Servers to access your Amazon EC2 Auto Scaling
    /// groups.
    role_arn: ?[]const u8,

    /// The current status of the game server group. Possible statuses include:
    ///
    /// * `NEW` - Amazon GameLift Servers FleetIQ has validated the
    ///   `CreateGameServerGroup()`
    /// request.
    ///
    /// * `ACTIVATING` - Amazon GameLift Servers FleetIQ is setting up a game server
    ///   group, which
    /// includes creating an Auto Scaling group in your Amazon Web Services account.
    ///
    /// * `ACTIVE` - The game server group has been successfully created.
    ///
    /// * `DELETE_SCHEDULED` - A request to delete the game server group has
    /// been received.
    ///
    /// * `DELETING` - Amazon GameLift Servers FleetIQ has received a valid
    /// `DeleteGameServerGroup()` request and is processing it. Amazon GameLift
    /// Servers FleetIQ
    /// must first complete and release hosts before it deletes the Auto Scaling
    /// group
    /// and the game server group.
    ///
    /// * `DELETED` - The game server group has been successfully deleted.
    ///
    /// * `ERROR` - The asynchronous processes of activating or deleting a
    /// game server group has failed, resulting in an error state.
    status: ?GameServerGroupStatus,

    /// Additional information about the current game server group status. This
    /// information
    /// might provide additional insight on groups that are in `ERROR` status.
    status_reason: ?[]const u8,

    /// A list of activities that are currently suspended for this game server
    /// group. If this
    /// property is empty, all activities are occurring.
    suspended_actions: ?[]const GameServerGroupAction,

    pub const json_field_names = .{
        .auto_scaling_group_arn = "AutoScalingGroupArn",
        .balancing_strategy = "BalancingStrategy",
        .creation_time = "CreationTime",
        .game_server_group_arn = "GameServerGroupArn",
        .game_server_group_name = "GameServerGroupName",
        .game_server_protection_policy = "GameServerProtectionPolicy",
        .instance_definitions = "InstanceDefinitions",
        .last_updated_time = "LastUpdatedTime",
        .role_arn = "RoleArn",
        .status = "Status",
        .status_reason = "StatusReason",
        .suspended_actions = "SuspendedActions",
    };
};
