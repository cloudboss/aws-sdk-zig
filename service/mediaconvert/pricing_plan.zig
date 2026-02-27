/// Specifies whether the pricing plan for the queue is on-demand or reserved.
/// For on-demand, you pay per minute, billed in increments of .01 minute. For
/// reserved, you pay for the transcoding capacity of the entire queue,
/// regardless of how much or how little you use it. Reserved pricing requires a
/// 12-month commitment.
pub const PricingPlan = enum {
    on_demand,
    reserved,

    pub const json_field_names = .{
        .on_demand = "ON_DEMAND",
        .reserved = "RESERVED",
    };
};
