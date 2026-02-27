/// Contains information about the relationship between an asset model and an
/// interface asset
/// model that is applied to it.
pub const InterfaceRelationship = struct {
    /// The ID of the asset model that has the interface applied to it.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};
