const ProcessorParameterName = @import("processor_parameter_name.zig").ProcessorParameterName;

/// Describes the processor parameter.
pub const ProcessorParameter = struct {
    /// The name of the parameter. Currently the following default values are
    /// supported: 3
    /// for `NumberOfRetries` and 60 for the `BufferIntervalInSeconds`. The
    /// `BufferSizeInMBs` ranges between 0.2 MB and up to 3MB. The default buffering
    /// hint is 1MB for all destinations, except Splunk. For Splunk, the default
    /// buffering hint is
    /// 256 KB.
    parameter_name: ProcessorParameterName,

    /// The parameter value.
    parameter_value: []const u8,

    pub const json_field_names = .{
        .parameter_name = "ParameterName",
        .parameter_value = "ParameterValue",
    };
};
