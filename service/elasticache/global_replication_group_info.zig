/// The name of the Global datastore and role of this replication group in the
/// Global
/// datastore.
pub const GlobalReplicationGroupInfo = struct {
    /// The name of the Global datastore
    global_replication_group_id: ?[]const u8,

    /// The role of the replication group in a Global datastore. Can be primary or
    /// secondary.
    global_replication_group_member_role: ?[]const u8,
};
