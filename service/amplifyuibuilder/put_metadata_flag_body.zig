/// Stores the metadata information about a feature on a form.
pub const PutMetadataFlagBody = struct {
    /// The new information to store.
    new_value: []const u8,

    pub const json_field_names = .{
        .new_value = "newValue",
    };
};
