/// Stores information for generating Amplify DataStore queries. Use a
/// `Predicate` to retrieve a subset of the data in a collection.
pub const Predicate = struct {
    /// A list of predicates to combine logically.
    @"and": ?[]const Predicate,

    /// The field to query.
    field: ?[]const u8,

    /// The value to use when performing the evaluation.
    operand: ?[]const u8,

    /// The type of value to use when performing the evaluation.
    operand_type: ?[]const u8,

    /// The operator to use to perform the evaluation.
    operator: ?[]const u8,

    /// A list of predicates to combine logically.
    @"or": ?[]const Predicate,

    pub const json_field_names = .{
        .@"and" = "and",
        .field = "field",
        .operand = "operand",
        .operand_type = "operandType",
        .operator = "operator",
        .@"or" = "or",
    };
};
