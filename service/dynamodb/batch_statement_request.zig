const AttributeValue = @import("attribute_value.zig").AttributeValue;
const ReturnValuesOnConditionCheckFailure = @import("return_values_on_condition_check_failure.zig").ReturnValuesOnConditionCheckFailure;

/// A PartiQL batch statement request.
pub const BatchStatementRequest = struct {
    /// The read consistency of the PartiQL batch request.
    consistent_read: ?bool,

    /// The parameters associated with a PartiQL statement in the batch request.
    parameters: ?[]const AttributeValue,

    /// An optional parameter that returns the item attributes for a PartiQL batch
    /// request
    /// operation that failed a condition check.
    ///
    /// There is no additional cost associated with requesting a return value aside
    /// from the
    /// small network and processing overhead of receiving a larger response. No
    /// read capacity
    /// units are consumed.
    return_values_on_condition_check_failure: ?ReturnValuesOnConditionCheckFailure,

    /// A valid PartiQL statement.
    statement: []const u8,

    pub const json_field_names = .{
        .consistent_read = "ConsistentRead",
        .parameters = "Parameters",
        .return_values_on_condition_check_failure = "ReturnValuesOnConditionCheckFailure",
        .statement = "Statement",
    };
};
