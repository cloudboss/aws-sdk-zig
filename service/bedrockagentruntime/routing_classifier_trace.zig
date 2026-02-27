const InvocationInput = @import("invocation_input.zig").InvocationInput;
const ModelInvocationInput = @import("model_invocation_input.zig").ModelInvocationInput;
const RoutingClassifierModelInvocationOutput = @import("routing_classifier_model_invocation_output.zig").RoutingClassifierModelInvocationOutput;
const Observation = @import("observation.zig").Observation;

/// A trace for a routing classifier.
pub const RoutingClassifierTrace = union(enum) {
    /// The classifier's invocation input.
    invocation_input: ?InvocationInput,
    /// The classifier's model invocation input.
    model_invocation_input: ?ModelInvocationInput,
    /// The classifier's model invocation output.
    model_invocation_output: ?RoutingClassifierModelInvocationOutput,
    /// The classifier's observation.
    observation: ?Observation,

    pub const json_field_names = .{
        .invocation_input = "invocationInput",
        .model_invocation_input = "modelInvocationInput",
        .model_invocation_output = "modelInvocationOutput",
        .observation = "observation",
    };
};
