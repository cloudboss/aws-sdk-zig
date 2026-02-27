/// The number of functions and amount of storage in use.
pub const AccountUsage = struct {
    /// The number of Lambda functions.
    function_count: i64 = 0,

    /// The amount of storage space, in bytes, that's being used by deployment
    /// packages and layer archives.
    total_code_size: i64 = 0,

    pub const json_field_names = .{
        .function_count = "FunctionCount",
        .total_code_size = "TotalCodeSize",
    };
};
