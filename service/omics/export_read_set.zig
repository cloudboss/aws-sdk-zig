/// A read set.
pub const ExportReadSet = struct {
    /// The set's ID.
    read_set_id: []const u8,

    pub const json_field_names = .{
        .read_set_id = "readSetId",
    };
};
