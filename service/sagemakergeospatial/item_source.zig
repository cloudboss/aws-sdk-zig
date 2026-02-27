const aws = @import("aws");

const AssetValue = @import("asset_value.zig").AssetValue;
const Geometry = @import("geometry.zig").Geometry;
const Properties = @import("properties.zig").Properties;

/// The structure representing the items in the response for
/// SearchRasterDataCollection.
pub const ItemSource = struct {
    /// This is a dictionary of Asset Objects data associated with the Item that
    /// can be downloaded or streamed, each with a unique key.
    assets: ?[]const aws.map.MapEntry(AssetValue),

    /// The searchable date and time of the item, in UTC.
    date_time: i64,

    /// The item Geometry in GeoJson format.
    geometry: Geometry,

    /// A unique Id for the source item.
    id: []const u8,

    /// This field contains additional properties of the item.
    properties: ?Properties,

    pub const json_field_names = .{
        .assets = "Assets",
        .date_time = "DateTime",
        .geometry = "Geometry",
        .id = "Id",
        .properties = "Properties",
    };
};
