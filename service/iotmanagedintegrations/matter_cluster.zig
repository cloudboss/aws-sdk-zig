const aws = @import("aws");

/// Describe a Matter cluster with an id, and the relevant attributes, commands,
/// and events.
pub const MatterCluster = struct {
    /// The Matter attributes.
    attributes: ?[]const u8,

    /// Describe the Matter commands with the Matter command identifier mapped to
    /// the command fields.
    commands: ?[]const aws.map.StringMapEntry,

    /// Describe the Matter events with the Matter event identifier mapped to the
    /// event fields.
    events: ?[]const aws.map.StringMapEntry,

    /// The cluster id.
    id: ?[]const u8,

    pub const json_field_names = .{
        .attributes = "attributes",
        .commands = "commands",
        .events = "events",
        .id = "id",
    };
};
