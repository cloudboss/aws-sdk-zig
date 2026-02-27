/// Represents the output of a `BatchUpdate` response operation.
pub const BatchUpdateObjectAttributesResponse = struct {
    /// ID that is associated with the object.
    object_identifier: ?[]const u8,

    pub const json_field_names = .{
        .object_identifier = "ObjectIdentifier",
    };
};
