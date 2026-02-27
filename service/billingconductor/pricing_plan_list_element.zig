/// A representation of a pricing plan.
pub const PricingPlanListElement = struct {
    /// The pricing plan Amazon Resource Names (ARN). This can be used to uniquely
    /// identify a pricing plan.
    arn: ?[]const u8,

    /// The time when the pricing plan was created.
    creation_time: i64 = 0,

    /// The pricing plan description.
    description: ?[]const u8,

    /// The most recent time when the pricing plan was modified.
    last_modified_time: i64 = 0,

    /// The name of a pricing plan.
    name: ?[]const u8,

    /// The pricing rules count that's currently associated with this pricing plan
    /// list element.
    size: i64 = 0,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .description = "Description",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .size = "Size",
    };
};
