/// The results of the BatchPutAttribute action.
pub const BatchPutAttributeOutput = struct {
    /// The attribute ID.
    attribute_identifier: []const u8,

    pub const json_field_names = .{
        .attribute_identifier = "attributeIdentifier",
    };
};
