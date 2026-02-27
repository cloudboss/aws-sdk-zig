/// Defines the information about the Amazon Web Services Region you're deleting
/// from your
/// replication set.
pub const DeleteRegionAction = struct {
    /// The name of the Amazon Web Services Region you're deleting from the
    /// replication set.
    region_name: []const u8,

    pub const json_field_names = .{
        .region_name = "regionName",
    };
};
