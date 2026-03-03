/// The database object that the schema conversion operation currently uses.
pub const ProcessedObject = struct {
    /// The type of the data provider. This parameter can store one of the following
    /// values:
    /// `"SOURCE"` or `"TARGET"`.
    endpoint_type: ?[]const u8 = null,

    /// The name of the database object.
    name: ?[]const u8 = null,

    /// The type of the database object. For example, a table, view, procedure, and
    /// so on.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .endpoint_type = "EndpointType",
        .name = "Name",
        .@"type" = "Type",
    };
};
