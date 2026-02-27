const ProcessorConfiguration = @import("processor_configuration.zig").ProcessorConfiguration;
const FallbackAction = @import("fallback_action.zig").FallbackAction;

/// The information about a processor in a channel flow.
pub const Processor = struct {
    /// The information about the type of processor and its identifier.
    configuration: ProcessorConfiguration,

    /// The sequence in which processors run. If you have multiple processors in a
    /// channel flow, message processing goes through each processor in the
    /// sequence. The value determines the sequence.
    /// At this point, we support only 1 processor within a flow.
    execution_order: i32,

    /// Determines whether to continue with message processing or stop it in cases
    /// where communication with a processor fails. If a processor has a fallback
    /// action of `ABORT` and
    /// communication with it fails, the processor sets the message status to
    /// `FAILED` and does not send the message to any recipients. Note that if the
    /// last processor in the channel flow sequence
    /// has a fallback action of `CONTINUE` and communication with the processor
    /// fails, then the message is considered processed and sent to recipients of
    /// the channel.
    fallback_action: FallbackAction,

    /// The name of the channel flow.
    name: []const u8,

    pub const json_field_names = .{
        .configuration = "Configuration",
        .execution_order = "ExecutionOrder",
        .fallback_action = "FallbackAction",
        .name = "Name",
    };
};
