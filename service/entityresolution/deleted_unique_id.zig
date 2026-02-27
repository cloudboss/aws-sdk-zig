/// The deleted unique ID.
pub const DeletedUniqueId = struct {
    /// The unique ID of the deleted item.
    unique_id: []const u8,

    pub const json_field_names = .{
        .unique_id = "uniqueId",
    };
};
