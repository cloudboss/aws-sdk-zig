/// Information about a constraint.
pub const ConstraintDetail = struct {
    /// The identifier of the constraint.
    constraint_id: ?[]const u8 = null,

    /// The description of the constraint.
    description: ?[]const u8 = null,

    /// The owner of the constraint.
    owner: ?[]const u8 = null,

    /// The identifier of the portfolio the product resides in. The constraint
    /// applies only to the instance of the product that lives within this
    /// portfolio.
    portfolio_id: ?[]const u8 = null,

    /// The identifier of the product the constraint applies to. Note that a
    /// constraint applies to a specific instance of a product within a certain
    /// portfolio.
    product_id: ?[]const u8 = null,

    /// The type of constraint.
    ///
    /// * `LAUNCH`
    ///
    /// * `NOTIFICATION`
    ///
    /// * STACKSET
    ///
    /// * `TEMPLATE`
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .constraint_id = "ConstraintId",
        .description = "Description",
        .owner = "Owner",
        .portfolio_id = "PortfolioId",
        .product_id = "ProductId",
        .@"type" = "Type",
    };
};
