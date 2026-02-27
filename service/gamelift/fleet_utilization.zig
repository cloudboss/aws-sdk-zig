/// Current resource utilization statistics in a specified fleet or location.
/// The location
/// value might refer to a fleet's remote location or its home region.
pub const FleetUtilization = struct {
    /// The number of active game sessions that are currently being hosted across
    /// all
    /// instances in the fleet location.
    active_game_session_count: ?i32,

    /// The number of server processes in `ACTIVE` status that are currently
    /// running across all instances in the fleet location.
    active_server_process_count: ?i32,

    /// The number of active player sessions that are currently being hosted across
    /// all
    /// instances in the fleet location.
    current_player_session_count: ?i32,

    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// that is assigned to a Amazon GameLift Servers fleet resource and uniquely
    /// identifies it. ARNs are unique across all Regions. Format is
    /// `arn:aws:gamelift:::fleet/fleet-a1234567-b8c9-0d1e-2fa3-b45c6d7e8912`.
    fleet_arn: ?[]const u8,

    /// A unique identifier for the fleet associated with the location.
    fleet_id: ?[]const u8,

    /// The fleet location for the fleet utilization information, expressed as an
    /// Amazon Web Services Region
    /// code, such as `us-west-2`.
    location: ?[]const u8,

    /// The maximum number of players allowed across all game sessions that are
    /// currently
    /// being hosted across all instances in the fleet location.
    maximum_player_session_count: ?i32,

    pub const json_field_names = .{
        .active_game_session_count = "ActiveGameSessionCount",
        .active_server_process_count = "ActiveServerProcessCount",
        .current_player_session_count = "CurrentPlayerSessionCount",
        .fleet_arn = "FleetArn",
        .fleet_id = "FleetId",
        .location = "Location",
        .maximum_player_session_count = "MaximumPlayerSessionCount",
    };
};
