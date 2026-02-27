/// Represents a single metadata entry associated with a case. Each entry
/// consists of a key-value pair that provides additional contextual information
/// about the case, such as classification tags, custom attributes, or
/// system-generated properties.
pub const CaseMetadataEntry = struct {
    /// The identifier for the metadata field. This key uniquely identifies the type
    /// of metadata being stored, such as "severity", "category", or "assignee".
    key: []const u8,

    /// The value associated with the metadata key. This contains the actual data
    /// for the metadata field identified by the key.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
