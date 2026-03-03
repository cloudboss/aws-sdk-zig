/// Represents the output batch AttachObject response operation.
pub const BatchAttachObjectResponse = struct {
    /// The `ObjectIdentifier` of the object that has been attached.
    attached_object_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .attached_object_identifier = "attachedObjectIdentifier",
    };
};
