const AssociateResourceError = @import("associate_resource_error.zig").AssociateResourceError;

/// A resource association result for a percentage custom line item.
pub const AssociateResourceResponseElement = struct {
    /// The resource ARN that was associated to the custom line item.
    arn: ?[]const u8 = null,

    /// An `AssociateResourceError` that will populate if the resource association
    /// fails.
    @"error": ?AssociateResourceError = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .@"error" = "Error",
    };
};
