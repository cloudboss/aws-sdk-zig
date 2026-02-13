const aws = @import("aws");

const OpsEntityItem = @import("ops_entity_item.zig").OpsEntityItem;

/// The result of the query.
pub const OpsEntity = struct {
    /// The data returned by the query.
    data: ?[]const aws.map.MapEntry(OpsEntityItem),

    /// The query ID.
    id: ?[]const u8,

    pub const json_field_names = .{
        .data = "Data",
        .id = "Id",
    };
};
