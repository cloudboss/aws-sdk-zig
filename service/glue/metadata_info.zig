const OtherMetadataValueListItem = @import("other_metadata_value_list_item.zig").OtherMetadataValueListItem;

/// A structure containing metadata information for a schema version.
pub const MetadataInfo = struct {
    /// The time at which the entry was created.
    created_time: ?[]const u8,

    /// The metadata key’s corresponding value.
    metadata_value: ?[]const u8,

    /// Other metadata belonging to the same metadata key.
    other_metadata_value_list: ?[]const OtherMetadataValueListItem,

    pub const json_field_names = .{
        .created_time = "CreatedTime",
        .metadata_value = "MetadataValue",
        .other_metadata_value_list = "OtherMetadataValueList",
    };
};
