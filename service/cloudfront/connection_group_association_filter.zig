/// Contains information about what CloudFront resources your connection groups
/// are associated with.
pub const ConnectionGroupAssociationFilter = struct {
    /// The ID of the Anycast static IP list.
    anycast_ip_list_id: ?[]const u8 = null,
};
