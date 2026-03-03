/// Represents the output of a CreateIndex response operation.
pub const BatchCreateIndexResponse = struct {
    /// The `ObjectIdentifier` of the index created by this operation.
    object_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .object_identifier = "ObjectIdentifier",
    };
};
