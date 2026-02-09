const AttributeValue = @import("attribute_value.zig").AttributeValue;
const ReturnValuesOnConditionCheckFailure = @import("return_values_on_condition_check_failure.zig").ReturnValuesOnConditionCheckFailure;

/// Represents a PartiQL statement that uses parameters.
pub const ParameterizedStatement = struct {
    /// The parameter values.
    parameters: ?[]const AttributeValue,

    /// An optional parameter that returns the item attributes for a PartiQL
    /// `ParameterizedStatement` operation that failed a condition check.
    ///
    /// There is no additional cost associated with requesting a return value aside
    /// from the
    /// small network and processing overhead of receiving a larger response. No
    /// read capacity
    /// units are consumed.
    return_values_on_condition_check_failure: ?ReturnValuesOnConditionCheckFailure,

    /// A PartiQL statement that uses parameters.
    statement: []const u8,
};
