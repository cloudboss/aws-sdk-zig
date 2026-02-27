/// A structure containing other metadata for a schema version belonging to the
/// same metadata key.
pub const OtherMetadataValueListItem = struct {
    /// The time at which the entry was created.
    created_time: ?[]const u8,

    /// The metadata key’s corresponding value for the other metadata belonging to
    /// the same metadata key.
    metadata_value: ?[]const u8,

    pub const json_field_names = .{
        .created_time = "CreatedTime",
        .metadata_value = "MetadataValue",
    };
};
