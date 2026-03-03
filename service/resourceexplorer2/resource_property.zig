/// A structure that describes a property of a resource.
pub const ResourceProperty = struct {
    /// Details about this property. The content of this field is a JSON object that
    /// varies based on the resource type.
    data: ?[]const u8 = null,

    /// The date and time that the information about this resource property was last
    /// updated.
    last_reported_at: ?i64 = null,

    /// The name of this property of the resource.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .data = "Data",
        .last_reported_at = "LastReportedAt",
        .name = "Name",
    };
};
