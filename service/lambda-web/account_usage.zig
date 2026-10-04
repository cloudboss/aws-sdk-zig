/// Contains your current web function usage for the current AWS Region.
pub const AccountUsage = struct {
    /// The number of web functions in your account in the current AWS Region.
    function_count: i32,

    pub const json_field_names = .{
        .function_count = "functionCount",
    };
};
