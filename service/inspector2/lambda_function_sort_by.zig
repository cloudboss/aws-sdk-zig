pub const LambdaFunctionSortBy = enum {
    critical,
    high,
    all,

    pub const json_field_names = .{
        .critical = "CRITICAL",
        .high = "HIGH",
        .all = "ALL",
    };
};
