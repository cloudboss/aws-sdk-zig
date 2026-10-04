/// A summary of a peer database of an Autonomous Database.
pub const AutonomousDatabasePeerSummary = struct {
    /// The Amazon Resource Name (ARN) of the peer Autonomous Database.
    autonomous_database_arn: ?[]const u8 = null,

    /// The unique identifier of the peer Autonomous Database.
    autonomous_database_id: ?[]const u8 = null,

    /// The Oracle Cloud Identifier (OCID) of the peer Autonomous Database.
    ocid: ?[]const u8 = null,

    /// The Amazon Web Services Region where the peer Autonomous Database is
    /// located.
    region: ?[]const u8 = null,

    pub const json_field_names = .{
        .autonomous_database_arn = "autonomousDatabaseArn",
        .autonomous_database_id = "autonomousDatabaseId",
        .ocid = "ocid",
        .region = "region",
    };
};
