const AgenticRetrieveMemoryMetadataFilterLeft = @import("agentic_retrieve_memory_metadata_filter_left.zig").AgenticRetrieveMemoryMetadataFilterLeft;
const AgenticRetrieveMemoryMetadataFilterOperator = @import("agentic_retrieve_memory_metadata_filter_operator.zig").AgenticRetrieveMemoryMetadataFilterOperator;
const AgenticRetrieveMemoryMetadataFilterRight = @import("agentic_retrieve_memory_metadata_filter_right.zig").AgenticRetrieveMemoryMetadataFilterRight;

/// A metadata filter expression, in the form accepted by the AgentCore Memory
/// RetrieveMemoryRecords operation. The expression has a left operand that
/// names the metadata key, an operator, and a right operand. For the EXISTS and
/// NOT_EXISTS operators, omit the right operand.
pub const AgenticRetrieveMemoryMetadataFilter = struct {
    /// The metadata key that the expression evaluates.
    left: AgenticRetrieveMemoryMetadataFilterLeft,

    /// The relationship that the metadata key and value must have for a memory
    /// record to match.
    operator: AgenticRetrieveMemoryMetadataFilterOperator,

    /// The value that the expression compares the metadata key against. Supply this
    /// value for every operator except EXISTS and NOT_EXISTS.
    right: ?AgenticRetrieveMemoryMetadataFilterRight = null,

    pub const json_field_names = .{
        .left = "left",
        .operator = "operator",
        .right = "right",
    };
};
