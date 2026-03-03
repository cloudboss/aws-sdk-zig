/// Contains information about the condition.
pub const Condition = struct {
    /// Represents the *equal* condition to be applied to a single field when
    /// querying for findings.
    eq: ?[]const []const u8 = null,

    /// Represents an *equal*
    /// **** condition to be applied to
    /// a single field when querying for findings.
    equals: ?[]const []const u8 = null,

    /// Represents a *greater than* condition to be applied to a single field
    /// when querying for findings.
    greater_than: ?i64 = null,

    /// Represents a *greater than or equal* condition to be applied to a
    /// single field when querying for findings.
    greater_than_or_equal: ?i64 = null,

    /// Represents a *greater than* condition to be applied to a single field
    /// when querying for findings.
    gt: ?i32 = null,

    /// Represents a *greater than or equal* condition to be applied to a
    /// single field when querying for findings.
    gte: ?i32 = null,

    /// Represents a *less than* condition to be applied to a single field when
    /// querying for findings.
    less_than: ?i64 = null,

    /// Represents a *less than or equal* condition to be applied to a single
    /// field when querying for findings.
    less_than_or_equal: ?i64 = null,

    /// Represents a *less than* condition to be applied to a single field when
    /// querying for findings.
    lt: ?i32 = null,

    /// Represents a *less than or equal* condition to be applied to a single
    /// field when querying for findings.
    lte: ?i32 = null,

    /// Represents the *match* condition to be applied to a single field when
    /// querying for findings.
    ///
    /// The *matches* condition is available only for create-filter and
    /// update-filter APIs.
    matches: ?[]const []const u8 = null,

    /// Represents the *not equal* condition to be applied to a single field
    /// when querying for findings.
    neq: ?[]const []const u8 = null,

    /// Represents a *not equal*
    /// **** condition to be applied
    /// to a single field when querying for findings.
    not_equals: ?[]const []const u8 = null,

    /// Represents the *not match* condition to be applied to a single field when
    /// querying for findings.
    ///
    /// The *not-matches* condition is available only for create-filter and
    /// update-filter APIs.
    not_matches: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .eq = "Eq",
        .equals = "Equals",
        .greater_than = "GreaterThan",
        .greater_than_or_equal = "GreaterThanOrEqual",
        .gt = "Gt",
        .gte = "Gte",
        .less_than = "LessThan",
        .less_than_or_equal = "LessThanOrEqual",
        .lt = "Lt",
        .lte = "Lte",
        .matches = "Matches",
        .neq = "Neq",
        .not_equals = "NotEquals",
        .not_matches = "NotMatches",
    };
};
