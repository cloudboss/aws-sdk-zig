/// An OpsItems that shares something in common with the current OpsItem. For
/// example, related
/// OpsItems can include OpsItems with similar error messages, impacted
/// resources, or statuses for
/// the impacted resource.
pub const RelatedOpsItem = struct {
    /// The ID of an OpsItem related to the current OpsItem.
    ops_item_id: []const u8,

    pub const json_field_names = .{
        .ops_item_id = "OpsItemId",
    };
};
