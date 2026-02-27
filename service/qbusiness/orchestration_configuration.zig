const OrchestrationControl = @import("orchestration_control.zig").OrchestrationControl;

/// Configuration information required to enable chat orchestration for your
/// Amazon Q Business application.
///
/// Chat orchestration is optimized to work for English language content. For
/// more details on language support in Amazon Q Business, see [Supported
/// languages](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/supported-languages.html).
pub const OrchestrationConfiguration = struct {
    /// Status information about whether chat orchestration is activated or
    /// deactivated for your Amazon Q Business application.
    control: OrchestrationControl,

    pub const json_field_names = .{
        .control = "control",
    };
};
