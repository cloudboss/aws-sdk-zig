const MemberType = @import("member_type.zig").MemberType;

/// The name of the attribute, which is one of the values defined in the
/// UserAttribute
/// enumeration.
pub const Delegate = struct {
    /// The identifier for the user or group associated as the resource's delegate.
    id: []const u8,

    /// The type of the delegate: user or group.
    @"type": MemberType,

    pub const json_field_names = .{
        .id = "Id",
        .@"type" = "Type",
    };
};
