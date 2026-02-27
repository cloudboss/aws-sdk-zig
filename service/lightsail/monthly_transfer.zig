/// Describes the monthly data transfer in and out of your virtual private
/// server (or
/// *instance*).
pub const MonthlyTransfer = struct {
    /// The amount allocated per month (in GB).
    gb_per_month_allocated: ?i32,

    pub const json_field_names = .{
        .gb_per_month_allocated = "gbPerMonthAllocated",
    };
};
