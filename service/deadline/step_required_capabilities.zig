const StepAmountCapability = @import("step_amount_capability.zig").StepAmountCapability;
const StepAttributeCapability = @import("step_attribute_capability.zig").StepAttributeCapability;

/// The details of required step capabilities.
pub const StepRequiredCapabilities = struct {
    /// The capability amounts that the step requires.
    amounts: []const StepAmountCapability,

    /// The capability attributes that the step requires.
    attributes: []const StepAttributeCapability,

    pub const json_field_names = .{
        .amounts = "amounts",
        .attributes = "attributes",
    };
};
