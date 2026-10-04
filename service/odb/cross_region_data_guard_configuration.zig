/// The configuration for creating an Autonomous Database as a cross-Region
/// Oracle Data Guard peer.
pub const CrossRegionDataGuardConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the source Autonomous Database for the
    /// cross-Region Oracle Data Guard configuration.
    source_autonomous_database_arn: []const u8,

    pub const json_field_names = .{
        .source_autonomous_database_arn = "sourceAutonomousDatabaseArn",
    };
};
