/// Describes a queue.
pub const Queue = struct {
    /// The name of the queue.
    name: ?[]const u8,

    /// The URL of the queue.
    url: ?[]const u8,
};
