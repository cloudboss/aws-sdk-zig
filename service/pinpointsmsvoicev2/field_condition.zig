/// A single condition on a dependency field's value. Conditions are combined
/// into a **ConditionalRule** and evaluated together with logical AND.
pub const FieldCondition = struct {
    /// The path of the field whose value determines this condition, for example
    /// **companyInfo.businessType**.
    depends_on_field_path: []const u8,

    /// The comparison operator to apply between the dependency field's value and
    /// **Values**. Valid values are **EQUALS**, **NOT_EQUALS**, **IN**, **NOT_IN**,
    /// **HAS_VALUE**, and **NO_VALUE**. Operators not in this list are treated as
    /// evaluating to false, which causes the containing rule to be skipped. This
    /// allows forward-compatible additions of new operators without breaking older
    /// SDK clients.
    operator: []const u8,

    /// The values to compare the dependency field's value against. Required for the
    /// **EQUALS**, **NOT_EQUALS**, **IN**, and **NOT_IN** operators. Omitted for
    /// **HAS_VALUE** and **NO_VALUE**, which test only presence.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .depends_on_field_path = "DependsOnFieldPath",
        .operator = "Operator",
        .values = "Values",
    };
};
