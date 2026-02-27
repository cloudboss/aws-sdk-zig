/// The object that is specified in resource record set object when you are
/// linking a
/// resource record set to a CIDR location.
///
/// A `LocationName` with an asterisk “*” can be used to create a default CIDR
/// record. `CollectionId` is still required for default record.
pub const CidrRoutingConfig = struct {
    /// The CIDR collection ID.
    collection_id: []const u8,

    /// The CIDR collection location name.
    location_name: []const u8,
};
