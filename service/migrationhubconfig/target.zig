const TargetType = @import("target_type.zig").TargetType;

/// The target parameter specifies the identifier to which the home region is
/// applied, which
/// is always an `ACCOUNT`. It applies the home region to the current
/// `ACCOUNT`.
pub const Target = struct {
    /// The `TargetID` is a 12-character identifier of the `ACCOUNT` for
    /// which the control was created. (This must be the current account.)
    id: ?[]const u8,

    /// The target type is always an `ACCOUNT`.
    @"type": TargetType,

    pub const json_field_names = .{
        .id = "Id",
        .@"type" = "Type",
    };
};
