const MetadataValue = @import("metadata_value.zig").MetadataValue;

/// Right expression of the `eventMetadata`filter.
pub const RightExpression = union(enum) {
    /// Value associated with the key in `eventMetadata`.
    metadata_value: ?MetadataValue,

    pub const json_field_names = .{
        .metadata_value = "metadataValue",
    };
};
