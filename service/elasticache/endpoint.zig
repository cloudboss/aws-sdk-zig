/// Represents the information required for client programs to connect to a
/// cache
/// node. This value is read-only.
pub const Endpoint = struct {
    /// The DNS hostname of the cache node.
    address: ?[]const u8,

    /// The port number that the cache engine is listening on.
    port: ?i32,
};
