const AssetType = @import("asset_type.zig").AssetType;
const Origin = @import("origin.zig").Origin;
const OriginDetails = @import("origin_details.zig").OriginDetails;

/// A data set is an AWS resource with one or more revisions.
pub const DataSetEntry = struct {
    /// The ARN for the data set.
    arn: []const u8,

    /// The type of asset that is added to a data set.
    asset_type: AssetType,

    /// The date and time that the data set was created, in ISO 8601 format.
    created_at: i64,

    /// The description for the data set.
    description: []const u8,

    /// The unique identifier for the data set.
    id: []const u8,

    /// The name of the data set.
    name: []const u8,

    /// A property that defines the data set as OWNED by the account (for providers)
    /// or ENTITLED
    /// to the account (for subscribers).
    origin: Origin,

    /// If the origin of this data set is ENTITLED, includes the details for the
    /// product on AWS
    /// Marketplace.
    origin_details: ?OriginDetails,

    /// The data set ID of the owned data set corresponding to the entitled data set
    /// being
    /// viewed. This parameter is returned when a data set owner is viewing the
    /// entitled copy of
    /// its owned data set.
    source_id: ?[]const u8,

    /// The date and time that the data set was last updated, in ISO 8601 format.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .asset_type = "AssetType",
        .created_at = "CreatedAt",
        .description = "Description",
        .id = "Id",
        .name = "Name",
        .origin = "Origin",
        .origin_details = "OriginDetails",
        .source_id = "SourceId",
        .updated_at = "UpdatedAt",
    };
};
