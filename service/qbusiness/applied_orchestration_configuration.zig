const OrchestrationControl = @import("orchestration_control.zig").OrchestrationControl;

/// The chat orchestration specific admin controls configured for an Amazon Q
/// Business application. Determines whether Amazon Q Business automatically
/// routes chat requests across configured plugins and data sources in your
/// Amazon Q Business application.
///
/// For more information, see [Chat orchestration
/// settings](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/guardrails-global-controls.html#guardrails-global-orchestration).
pub const AppliedOrchestrationConfiguration = struct {
    /// Information about whether chat orchestration is enabled or disabled for an
    /// Amazon Q Business application.
    control: OrchestrationControl,

    pub const json_field_names = .{
        .control = "control",
    };
};
