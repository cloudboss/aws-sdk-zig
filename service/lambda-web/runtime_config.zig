/// The runtime configuration for a web function revision.
pub const RuntimeConfig = struct {
    /// The runtime identifier for the web function (for example, a Node.js runtime
    /// identifier).
    runtime: []const u8,

    pub const json_field_names = .{
        .runtime = "runtime",
    };
};
