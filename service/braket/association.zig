const AssociationType = @import("association_type.zig").AssociationType;

/// The Amazon Braket resource and the association type.
pub const Association = struct {
    /// The Amazon Braket resource arn.
    arn: []const u8,

    /// The association type for the specified Amazon Braket resource arn.
    type: AssociationType,

    pub const json_field_names = .{
        .arn = "arn",
        .type = "type",
    };
};
