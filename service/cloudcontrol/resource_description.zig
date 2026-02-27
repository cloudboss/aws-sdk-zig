/// Represents information about a provisioned resource.
pub const ResourceDescription = struct {
    /// The primary identifier for the resource.
    ///
    /// For more information, see [Identifying
    /// resources](https://docs.aws.amazon.com/cloudcontrolapi/latest/userguide/resource-identifier.html) in the *Amazon Web Services Cloud Control API User Guide*.
    identifier: ?[]const u8,

    /// A list of the resource properties and their current values.
    properties: ?[]const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
        .properties = "Properties",
    };
};
