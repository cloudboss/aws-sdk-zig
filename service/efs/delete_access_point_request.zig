pub const DeleteAccessPointRequest = struct {
    /// The ID of the access point that you want to delete.
    access_point_id: []const u8,

    pub const json_field_names = .{
        .access_point_id = "AccessPointId",
    };
};
