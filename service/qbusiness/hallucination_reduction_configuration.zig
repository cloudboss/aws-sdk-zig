const HallucinationReductionControl = @import("hallucination_reduction_control.zig").HallucinationReductionControl;

/// Configuration information required to setup hallucination reduction. For
/// more information, see [ hallucination
/// reduction](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/hallucination-reduction.html).
///
/// The hallucination reduction feature won't work if chat orchestration
/// controls are enabled for your application.
pub const HallucinationReductionConfiguration = struct {
    /// Controls whether hallucination reduction has been enabled or disabled for
    /// your application. The default status is `DISABLED`.
    hallucination_reduction_control: ?HallucinationReductionControl = null,

    pub const json_field_names = .{
        .hallucination_reduction_control = "hallucinationReductionControl",
    };
};
