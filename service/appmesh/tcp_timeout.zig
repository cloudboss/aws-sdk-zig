const Duration = @import("duration.zig").Duration;

/// An object that represents types of timeouts.
pub const TcpTimeout = struct {
    /// An object that represents an idle timeout. An idle timeout bounds the amount
    /// of time that a connection may be idle. The default value is none.
    idle: ?Duration,

    pub const json_field_names = .{
        .idle = "idle",
    };
};
