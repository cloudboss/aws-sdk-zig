/// Indicates whether replication is enabled or disabled for the endpoint. If
/// enabled, the endpoint can replicate all
/// events to a secondary Amazon Web Services Region.
pub const AwsEventsEndpointReplicationConfigDetails = struct {
    /// The state of event replication.
    state: ?[]const u8,

    pub const json_field_names = .{
        .state = "State",
    };
};
