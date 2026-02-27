const Duration = @import("duration.zig").Duration;

/// An object that represents types of timeouts.
pub const HttpTimeout = struct {
    /// An object that represents an idle timeout. An idle timeout bounds the amount
    /// of time that a connection may be idle. The default value is none.
    idle: ?Duration,

    /// An object that represents a per request timeout. The default value is 15
    /// seconds. If you set a higher timeout, then make sure that the higher value
    /// is set for each App Mesh
    /// resource in a conversation. For example, if a virtual node backend uses a
    /// virtual router provider to route to another virtual node, then the timeout
    /// should be greater than 15
    /// seconds for the source and destination virtual node and the route.
    per_request: ?Duration,

    pub const json_field_names = .{
        .idle = "idle",
        .per_request = "perRequest",
    };
};
