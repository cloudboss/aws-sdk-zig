/// Contains summary information about an interface relationship, which defines
/// how an
/// interface is applied to an asset model. This summary provides the essential
/// identifiers needed
/// to retrieve detailed information about the relationship.
pub const InterfaceRelationshipSummary = struct {
    /// The ID of the asset model that has the interface applied to it.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};
