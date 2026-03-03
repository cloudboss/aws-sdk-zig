const Tag = @import("tag.zig").Tag;

pub const CreateFleetRequest = struct {
    /// A brief description of the fleet to create.
    description: ?[]const u8 = null,

    /// The unique ID of the fleet to create.
    fleet_id: []const u8,

    /// The Amazon Resource Name (ARN) of a signal catalog.
    signal_catalog_arn: []const u8,

    /// Metadata that can be used to manage the fleet.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .description = "description",
        .fleet_id = "fleetId",
        .signal_catalog_arn = "signalCatalogArn",
        .tags = "tags",
    };
};
