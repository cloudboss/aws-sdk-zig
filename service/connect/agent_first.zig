const Preview = @import("preview.zig").Preview;

/// Information about agent-first outbound strategy configuration.
pub const AgentFirst = struct {
    /// Information about preview configuration of agent first outbound strategy
    preview: ?Preview,

    pub const json_field_names = .{
        .preview = "Preview",
    };
};
