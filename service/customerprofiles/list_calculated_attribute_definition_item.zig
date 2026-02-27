const aws = @import("aws");

const ReadinessStatus = @import("readiness_status.zig").ReadinessStatus;

/// The details of a single calculated attribute definition.
pub const ListCalculatedAttributeDefinitionItem = struct {
    /// The unique name of the calculated attribute.
    calculated_attribute_name: ?[]const u8,

    /// The threshold for the calculated attribute.
    created_at: ?i64,

    /// The threshold for the calculated attribute.
    description: ?[]const u8,

    /// The display name of the calculated attribute.
    display_name: ?[]const u8,

    /// The timestamp of when the calculated attribute definition was most recently
    /// edited.
    last_updated_at: ?i64,

    /// Status of the Calculated Attribute creation (whether all historical data has
    /// been
    /// indexed.)
    status: ?ReadinessStatus,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry,

    /// Whether historical data ingested before the Calculated Attribute was created
    /// should be
    /// included in calculations.
    use_historical_data: ?bool,

    pub const json_field_names = .{
        .calculated_attribute_name = "CalculatedAttributeName",
        .created_at = "CreatedAt",
        .description = "Description",
        .display_name = "DisplayName",
        .last_updated_at = "LastUpdatedAt",
        .status = "Status",
        .tags = "Tags",
        .use_historical_data = "UseHistoricalData",
    };
};
