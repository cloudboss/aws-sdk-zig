const TargetId = @import("target_id.zig").TargetId;
const TargetType = @import("target_type.zig").TargetType;

/// A target identifier is a pair of identifying information for a scope that is
/// included in a target. A target identifier is made up of a target ID and a
/// target type. Currently the target ID is always an account ID and the target
/// type is always ACCOUNT.
pub const TargetIdentifier = struct {
    /// The identifier for a target, which is currently always an account ID .
    target_id: TargetId,

    /// The type of a target. A target type is currently always `ACCOUNT`.
    target_type: TargetType,

    pub const json_field_names = .{
        .target_id = "targetId",
        .target_type = "targetType",
    };
};
