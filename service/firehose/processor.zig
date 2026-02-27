const ProcessorParameter = @import("processor_parameter.zig").ProcessorParameter;
const ProcessorType = @import("processor_type.zig").ProcessorType;

/// Describes a data processor.
///
/// If you want to add a new line delimiter between records in objects that are
/// delivered to Amazon S3, choose `AppendDelimiterToRecord` as a processor
/// type. You don’t have to put a processor parameter when you select
/// `AppendDelimiterToRecord`.
pub const Processor = struct {
    /// The processor parameters.
    parameters: ?[]const ProcessorParameter,

    /// The type of processor.
    type: ProcessorType,

    pub const json_field_names = .{
        .parameters = "Parameters",
        .type = "Type",
    };
};
