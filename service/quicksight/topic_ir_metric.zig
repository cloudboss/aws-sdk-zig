const Identifier = @import("identifier.zig").Identifier;
const TopicIRComparisonMethod = @import("topic_ir_comparison_method.zig").TopicIRComparisonMethod;
const DisplayFormat = @import("display_format.zig").DisplayFormat;
const DisplayFormatOptions = @import("display_format_options.zig").DisplayFormatOptions;
const AggFunction = @import("agg_function.zig").AggFunction;
const NamedEntityRef = @import("named_entity_ref.zig").NamedEntityRef;

/// The definition for a `TopicIRMetric`.
pub const TopicIRMetric = struct {
    /// The calculated field references for the `TopicIRMetric`.
    calculated_field_references: ?[]const Identifier,

    /// The comparison method for the `TopicIRMetric`.
    comparison_method: ?TopicIRComparisonMethod,

    /// The display format for the `TopicIRMetric`.
    display_format: ?DisplayFormat,

    display_format_options: ?DisplayFormatOptions,

    /// The expression for the `TopicIRMetric`.
    expression: ?[]const u8,

    /// The function for the `TopicIRMetric`.
    function: ?AggFunction,

    /// The metric ID for the `TopicIRMetric`.
    metric_id: ?Identifier,

    /// The named entity for the `TopicIRMetric`.
    named_entity: ?NamedEntityRef,

    /// The operands for the `TopicIRMetric`.
    operands: ?[]const Identifier,

    pub const json_field_names = .{
        .calculated_field_references = "CalculatedFieldReferences",
        .comparison_method = "ComparisonMethod",
        .display_format = "DisplayFormat",
        .display_format_options = "DisplayFormatOptions",
        .expression = "Expression",
        .function = "Function",
        .metric_id = "MetricId",
        .named_entity = "NamedEntity",
        .operands = "Operands",
    };
};
