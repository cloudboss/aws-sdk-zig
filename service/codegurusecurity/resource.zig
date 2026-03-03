/// Information about a resource that contains a finding.
pub const Resource = struct {
    /// The `scanName` of the scan that was run on the resource.
    id: ?[]const u8 = null,

    /// The identifier for a section of the resource.
    sub_resource_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
        .sub_resource_id = "subResourceId",
    };
};
