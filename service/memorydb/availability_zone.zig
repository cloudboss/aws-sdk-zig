/// Indicates if the cluster has a Multi-AZ configuration (multiaz) or not
/// (singleaz).
pub const AvailabilityZone = struct {
    /// The name of the Availability Zone.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
    };
};
