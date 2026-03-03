/// Represents the output of a AttachToIndex response operation.
pub const BatchAttachToIndexResponse = struct {
    /// The `ObjectIdentifier` of the object that was attached to the index.
    attached_object_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .attached_object_identifier = "AttachedObjectIdentifier",
    };
};
