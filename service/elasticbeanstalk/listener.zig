/// Describes the properties of a Listener for the LoadBalancer.
pub const Listener = struct {
    /// The port that is used by the Listener.
    port: i32 = 0,

    /// The protocol that is used by the Listener.
    protocol: ?[]const u8 = null,
};
