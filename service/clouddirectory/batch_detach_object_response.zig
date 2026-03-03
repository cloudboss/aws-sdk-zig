/// Represents the output of a DetachObject response operation.
pub const BatchDetachObjectResponse = struct {
    /// The `ObjectIdentifier` of the detached object.
    detached_object_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .detached_object_identifier = "detachedObjectIdentifier",
    };
};
