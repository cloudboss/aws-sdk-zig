/// A fleet or alias designated in a game session queue. Queues fulfill requests
/// for new
/// game sessions by placing a new game session on any of the queue's
/// destinations.
pub const GameSessionQueueDestination = struct {
    /// The Amazon Resource Name (ARN) that is assigned to fleet or fleet alias.
    /// ARNs, which
    /// include a fleet ID or alias ID and a Region name, provide a unique
    /// identifier across all
    /// Regions.
    destination_arn: ?[]const u8,

    pub const json_field_names = .{
        .destination_arn = "DestinationArn",
    };
};
