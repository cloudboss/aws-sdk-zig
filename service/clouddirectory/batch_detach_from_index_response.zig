/// Represents the output of a DetachFromIndex response operation.
pub const BatchDetachFromIndexResponse = struct {
    /// The `ObjectIdentifier` of the object that was detached from the index.
    detached_object_identifier: ?[]const u8,

    pub const json_field_names = .{
        .detached_object_identifier = "DetachedObjectIdentifier",
    };
};
