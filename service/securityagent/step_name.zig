const std = @import("std");

/// Pentest job step names.
pub const StepName = enum {
    /// Pre-flight validation and setup step.
    preflight,
    /// Static code and network scan analysis step.
    static_analysis,
    /// Active pentest step.
    pentest,
    /// Cleanup of infrastructure and resources created by the agent.
    finalizing,
    /// Simulated validation step that dynamically confirms vulnerability
    /// exploitability.
    validation,

    pub const json_field_names = .{
        .preflight = "PREFLIGHT",
        .static_analysis = "STATIC_ANALYSIS",
        .pentest = "PENTEST",
        .finalizing = "FINALIZING",
        .validation = "VALIDATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .preflight => "PREFLIGHT",
            .static_analysis => "STATIC_ANALYSIS",
            .pentest => "PENTEST",
            .finalizing => "FINALIZING",
            .validation => "VALIDATION",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
