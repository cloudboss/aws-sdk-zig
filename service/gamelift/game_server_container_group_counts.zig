/// The number and status of game server container groups that are deployed
/// across a container fleet.
/// Combine this count with the number of server processes that each game server
/// container group runs
/// to learn how many game sessions the fleet is capable of hosting
/// concurrently. For example, if a
/// fleet has 50 game server container groups, and the game server container in
/// each group runs 1 game server
/// process, then the fleet has the capacity to run host 50 game sessions at a
/// time.
///
/// **Returned by:**
/// [https://docs.aws.amazon.com/gamelift/latest/apireference/API_DescribeFleetCapacity.html](https://docs.aws.amazon.com/gamelift/latest/apireference/API_DescribeFleetCapacity.html), [https://docs.aws.amazon.com/gamelift/latest/apireference/API_DescribeFleetLocationCapacity.html](https://docs.aws.amazon.com/gamelift/latest/apireference/API_DescribeFleetLocationCapacity.html)
pub const GameServerContainerGroupCounts = struct {
    /// The number of container groups that have active game sessions.
    active: ?i32,

    /// The number of container groups that have no active game sessions.
    idle: ?i32,

    /// The number of container groups that are starting up but haven't yet
    /// registered.
    pending: ?i32,

    /// The number of container groups that are in the process of shutting down.
    terminating: ?i32,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .idle = "IDLE",
        .pending = "PENDING",
        .terminating = "TERMINATING",
    };
};
