const Processor = @import("processor.zig").Processor;

/// Describes a data processing configuration.
pub const ProcessingConfiguration = struct {
    /// Enables or disables data processing.
    enabled: ?bool,

    /// The data processors.
    processors: ?[]const Processor,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .processors = "Processors",
    };
};
