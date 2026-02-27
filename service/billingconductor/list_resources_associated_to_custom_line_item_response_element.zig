const CustomLineItemRelationship = @import("custom_line_item_relationship.zig").CustomLineItemRelationship;

/// A representation of a resource association for a custom line item.
pub const ListResourcesAssociatedToCustomLineItemResponseElement = struct {
    /// The ARN of the associated resource.
    arn: ?[]const u8,

    /// The end billing period of the associated resource.
    end_billing_period: ?[]const u8,

    /// The type of relationship between the custom line item and the associated
    /// resource.
    relationship: ?CustomLineItemRelationship,

    pub const json_field_names = .{
        .arn = "Arn",
        .end_billing_period = "EndBillingPeriod",
        .relationship = "Relationship",
    };
};
