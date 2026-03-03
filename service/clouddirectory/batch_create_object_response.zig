/// Represents the output of a CreateObject response operation.
pub const BatchCreateObjectResponse = struct {
    /// The ID that is associated with the object.
    object_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .object_identifier = "ObjectIdentifier",
    };
};
