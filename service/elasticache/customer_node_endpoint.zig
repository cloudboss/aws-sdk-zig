/// The endpoint from which data should be migrated.
pub const CustomerNodeEndpoint = struct {
    /// The address of the node endpoint
    address: ?[]const u8,

    /// The port of the node endpoint
    port: ?i32,
};
