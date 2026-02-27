const AssociateResourceError = @import("associate_resource_error.zig").AssociateResourceError;

/// A resource disassociation result for a percentage custom line item.
pub const DisassociateResourceResponseElement = struct {
    /// The resource ARN that was disassociated from the custom line item.
    arn: ?[]const u8,

    /// An `AssociateResourceError` that's shown if the resource disassociation
    /// fails.
    @"error": ?AssociateResourceError,

    pub const json_field_names = .{
        .arn = "Arn",
        .@"error" = "Error",
    };
};
